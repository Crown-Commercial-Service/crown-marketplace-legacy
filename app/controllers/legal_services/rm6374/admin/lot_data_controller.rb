module LegalServices
  module RM6374
    module Admin
      class LotDataController < LegalServices::Admin::FrameworkController
        include ::Admin::LotDataActions

        LOT_SORT_CRITERIA = 'lots.number'.freeze

        SECTIONS_TO_SHOW = %i[services jurisdictions rates].freeze
        SECTIONS_TO_EDIT = %i[lot_status services jurisdictions rates].freeze

        private

        def set_section_data
          case @section
          when :jurisdictions
            @jurisdictions = [[nil, Jurisdiction.where(framework_id: 'RM6374').where.not(code: 'GB')]]
          else
            super
          end
        end

        def lot_sections(lot)
          lot.number == '6' ? %i[services rates] : %i[services jurisdictions rates]
        end

        def set_supplier_framework_lot_data_for_jurisdictions
          @supplier_framework_lot_jurisdiction_ids = super.reject { |jurisdiction_id| jurisdiction_id == 'RM6374.GB' }
        end

        def jurisdiction_code
          @jurisdiction_code = "#{@framework.id}.GB"
        end

        def set_supplier_framework_lot_data_for_rates
          @supplier_framework_lot_jurisdiction = @supplier_framework_lot.jurisdictions.find_by(jurisdiction_id: params.fetch(:jurisdiction_id, "#{@framework.id}.GB"))
          if @lot.number == '2'
            set_lot_2_rates
          else
            set_non_lot_2_rates
          end
        end

        def set_non_lot_2_rates
          if action_name.to_sym == :show
            @supplier_framework_lot_rates = @supplier_framework.grouped_rates_for_lot(@lot.id)
          else
            existing_rates = @supplier_framework_lot.rates.index_by(&:position_id)

            @supplier_framework_lot_rates = @lot.positions.pluck(:id).index_with do |position_id|
              existing_rates[position_id] || @supplier_framework_lot.rates.build(position_id:)
            end
          end
        end

        def set_lot_2_rates
          if action_name.to_sym == :show
            @supplier_framework_lot_rates = @supplier_framework_lot.rates.includes(:position)
          else
            @service_id = params[:service_id]
            @selected_service_name = Service.find_by(id: @service_id)&.name || @service_id

            existing_rates = @supplier_framework_lot.rates.where(service_id: @service_id).index_by(&:position_id)

            @supplier_framework_lot_rates = @lot.positions.pluck(:id).index_with do |position_id|
              existing_rates[position_id] || @supplier_framework_lot.rates.build(
                position_id: position_id,
                service_id: @service_id
              )
            end
          end
        end

        def update_for_rates # rubocop:disable Metrics/AbcSize,Metrics/CyclomaticComplexity,Metrics/MethodLength,Metrics/PerceivedComplexity
          @service_id = params[:service_id] || params.dig(@model.model_name.param_key, :service_id)
          set_lot_2_rates if @lot.number == '2' && @supplier_framework_lot_rates.blank?

          rates_params = if params[@model.model_name.param_key].present?
                           params.expect("#{@model.model_name.param_key}": { rates: @lot.positions.pluck(:id).map(&:to_sym) })
                         else
                           {}
                         end
          rates = rates_params[:rates] || {}

          valid_rates = @supplier_framework_lot_rates.map do |position_id, supplier_framework_lot_rate|
            supplier_framework_lot_rate.assign_rate_and_validate?(rates[position_id])
          end

          if valid_rates.all?
            begin
              ActiveRecord::Base.transaction do
                lot_jurisdictions = @supplier_framework_lot.jurisdictions

                @supplier_framework_lot_rates.each do |position_id, supplier_framework_lot_rate|
                  supplier_framework_lot_rate.service_id = @service_id if @service_id.present?

                  saving_rates(supplier_framework_lot_rate)

                  lot_jurisdictions.each do |jurisdiction|
                    next if supplier_framework_lot_rate.supplier_framework_lot_jurisdiction_id == jurisdiction.id

                    other_rate = @supplier_framework_lot.rates.find_or_initialize_by(
                      {
                        position_id: position_id,
                        supplier_framework_lot_jurisdiction_id: jurisdiction.id,
                        service_id: (@service_id if @lot.number == '2')
                      }.compact
                    )

                    if supplier_framework_lot_rate.rate.nil?
                      other_rate.destroy! if other_rate.persisted?
                    else
                      other_rate.rate = supplier_framework_lot_rate.rate
                      other_rate.save!
                    end
                  end
                end

                # Log change audit
                ChangeLog.log_update_supplier_framework_lot_rates!(
                  user: current_user,
                  framework: params[:framework],
                  model: @model,
                  rates: @supplier_framework_lot_rates
                )
              end

              true
            rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved => e
              Rails.logger.error e
              Rollbar.log('error', e) if defined?(Rollbar)

              @supplier_framework_lot_rates.each_value do |supplier_framework_lot_rate|
                supplier_framework_lot_rate.errors.add(:rate, :update_invalid)
              end

              false
            end
          else
            false
          end
        end

        def saving_rates(supplier_framework_lot_rate)
          if supplier_framework_lot_rate.rate.nil?
            if supplier_framework_lot_rate.persisted?
              supplier_framework_lot_rate.reload
              supplier_framework_lot_rate.destroy!
            end
          else
            supplier_framework_lot_rate.save!
          end
        end
      end
    end
  end
end

module LegalPanelForGovernment
  module RM6360
    module Admin
      class JurisdictionsController < LegalPanelForGovernment::Admin::FrameworkController
        include ::Admin::SupplierPathsConcern

        before_action :set_framework, :set_supplier_framework, :set_lot, :set_supplier_framework_lot, :set_section
        before_action :set_jurisdiction_model, only: %i[edit update]
        before_action :set_jurisdiction, only: %i[new create delete destroy]
        before_action :redirect_if_supplier_framework_lot_jurisdiction_does_not_exist, only: %i[delete destroy]
        before_action :redirect_if_supplier_framework_lot_jurisdiction_exists, :build_jurisdiction_and_rates, only: %i[new create]

        def new; end

        def edit; end

        # rubocop:disable Metrics/AbcSize
        def create
          ActiveRecord::Base.transaction do
            @supplier_framework_lot_jurisdiction.save!

            rates = create_params[:rates]

            valid_rates = @supplier_framework_lot_rates.map do |position_id, supplier_framework_lot_rate|
              supplier_framework_lot_rate.jurisdiction = @supplier_framework_lot_jurisdiction
              supplier_framework_lot_rate.assign_rate_and_validate?(rates[position_id])
            end

            raise ActiveRecord::Rollback unless valid_rates.all?

            @supplier_framework_lot_rates.each_value do |supplier_framework_lot_rate|
              next if supplier_framework_lot_rate.rate.nil?

              supplier_framework_lot_rate.save!
            end
            ChangeLog.log_add_rates_for_supplier_framework_lot_jurisdiction!(user: current_user, framework: params[:framework], model: @supplier_framework_lot, rates: @supplier_framework_lot_rates)

            flash[:jurisdiction_added] = @supplier_framework_lot_jurisdiction.jurisdiction.name

            return redirect_to(legal_panel_for_government_rm6360_admin_jurisdictions_edit_path)
          rescue ActiveRecord::RecordInvalid => e
            Rails.logger.error e
            Rollbar.log('error', e)

            @supplier_framework_lot_rates.each_value do |supplier_framework_lot_rate|
              supplier_framework_lot_rate.errors.add(:rate, :update_invalid)
            end
          end

          render :new
        end
        # rubocop:enable Metrics/AbcSize

        def update
          @model.assign_attributes(update_params)

          if @model.valid?
            if @model.add_or_remove == 'add'
              redirect_to legal_panel_for_government_rm6360_admin_jurisdictions_new_path(jurisdiction_id: @model.jurisdiction_to_add.gsub('.', '-'))
            else
              redirect_to legal_panel_for_government_rm6360_admin_jurisdictions_delete_path(jurisdiction_id: @model.jurisdiction_to_remove.gsub('.', '-'))
            end
          else
            render :edit
          end
        end

        def delete; end

        def destroy
          ActiveRecord::Base.transaction do
            supplier_framework_lot_rates = @supplier_framework_lot_jurisdiction.rates.index_by(&:position_id)
            @supplier_framework_lot_jurisdiction.destroy!
            ChangeLog.log_remove_rates_for_supplier_framework_lot_jurisdiction!(user: current_user, framework: params[:framework], model: @supplier_framework_lot, rates: supplier_framework_lot_rates)

            flash[:jurisdiction_removed] = @supplier_framework_lot_jurisdiction.jurisdiction.name

            return redirect_to(legal_panel_for_government_rm6360_admin_jurisdictions_edit_path)
          end

          render :delete
        end

        private

        def set_framework
          @framework = Framework.find(params.expect(:framework))
        end

        # rubocop:disable Rails/DynamicFindBy
        def set_lot
          @lot = @framework.lots.find_by_number_as_slug(params[:lot_number])
        end
        # rubocop:enable Rails/DynamicFindBy

        def set_supplier_framework
          @supplier_framework = Supplier::Framework.includes(:supplier).find(params.expect(:supplier_id))
        end

        def set_supplier_framework_lot
          @supplier_framework_lot = @supplier_framework.lots.find_by(lot_id: @lot.id)
        end

        def set_section
          @section = :jurisdictions
        end

        def set_jurisdiction_model
          @model = ChangeJurisdictions.new(jurisdiction_ids: @supplier_framework_lot.jurisdictions.pluck(:jurisdiction_id))
        end

        def set_jurisdiction
          @supplier_framework_lot_jurisdiction = @supplier_framework_lot.jurisdictions.find_by(jurisdiction_id:)
        end

        def redirect_if_supplier_framework_lot_jurisdiction_does_not_exist
          redirect_to(legal_panel_for_government_rm6360_admin_jurisdictions_edit_path) unless @supplier_framework_lot_jurisdiction
        end

        def redirect_if_supplier_framework_lot_jurisdiction_exists
          redirect_to(legal_panel_for_government_rm6360_admin_jurisdictions_edit_path) if @supplier_framework_lot_jurisdiction
        end

        def build_jurisdiction_and_rates
          @supplier_framework_lot_jurisdiction = @supplier_framework_lot.jurisdictions.build(jurisdiction_id:)
          @supplier_framework_lot_rates = @lot.positions.pluck(:id).index_with { |position_id| @supplier_framework_lot.rates.build(position_id: position_id, supplier_framework_lot_jurisdiction_id: @supplier_framework_lot_jurisdiction.id) }
        end

        def jurisdiction_id
          @jurisdiction_id ||= params.expect(:jurisdiction_id).gsub('-', '.')
        end

        def update_params
          params.expect(legal_panel_for_government_rm6360_admin_change_jurisdictions: %i[add_or_remove jurisdiction_to_add jurisdiction_to_remove])
        end

        def create_params
          params.expect(supplier_framework_lot: { rates: @lot.positions.pluck(:id).map(&:to_sym) })
        end
      end
    end
  end
end

module LegalPanelForGovernment
  module RM6360
    module Admin
      class LotDataController < LegalPanelForGovernment::Admin::FrameworkController
        include ::Admin::LotDataController

        LOT_SORT_CRITERIA = 'lots.number'.freeze

        SECTIONS_TO_SHOW = %i[services jurisdictions rates].freeze
        SECTIONS_TO_EDIT = %i[lot_status services rates].freeze

        private

        def set_section_data
          case @section
          when :jurisdictions
            @jurisdictions = Jurisdiction.non_core.order(:name)
          when :rates
            @jurisdictions = if @lot.number.starts_with?('4')
                               Jurisdiction.non_core.or(Jurisdiction.where(id: 'GB')).order(:name)
                             else
                               Jurisdiction.where(id: 'GB').order(:name)
                             end
          else
            super
          end
        end

        def set_supplier_framework_lot_data_for_rates
          if action_name.to_sym == :show
            @supplier_framework_lot_rates = @supplier_framework.grouped_rates_for_lot_and_jurisdictions(@lot.id, @jurisdictions.pluck(:id))
          else
            super
          end
        end

        def lot_sections(lot)
          %i[services] + (lot.number.starts_with?('4') ? [:jurisdictions] : []) + %i[rates]
        end
      end
    end
  end
end

module LegalPanelForGovernment
  module RM6360
    module Admin
      class LotDataController < LegalPanelForGovernment::Admin::FrameworkController
        include ::Admin::LotDataController

        LOT_SORT_CRITERIA = 'lots.number'.freeze

        private

        def set_section_data
          case params[:section]
          when 'rates'
            @jurisdictions = if @lot.number.starts_with?('4')
                               Jurisdiction.non_core.or(Jurisdiction.where(id: 'GB')).order(:name)
                             else
                               Jurisdiction.where(id: 'GB').order(:name)
                             end
          when 'jurisdictions'
            @jurisdictions = Jurisdiction.non_core.order(:name)
          else
            super
          end
        end

        def set_supplier_framework_data
          case params[:section]
          when 'rates'
            @supplier_framework_lot_rates = @supplier_framework.grouped_rates_for_lot_and_jurisdictions(@lot.id, @jurisdictions.pluck(:id))
          else
            super
          end
        end

        def lot_sections(lot)
          %i[services rates] + (lot.number.starts_with?('4') ? [:jurisdictions] : [])
        end
      end
    end
  end
end

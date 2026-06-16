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

        def lot_sections(_lot)
          %i[services jurisdictions rates]
        end

        # We need to mkae sure the GB jurisdiction is not removed as this is the one the rates sit on
        def set_supplier_framework_lot_data_for_jurisdictions
          @supplier_framework_lot_jurisdiction_ids = super.reject { |jurisdiction_id| jurisdiction_id == 'RM6374.GB' }
        end
      end
    end
  end
end

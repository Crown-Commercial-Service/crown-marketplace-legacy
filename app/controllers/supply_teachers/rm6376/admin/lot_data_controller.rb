module SupplyTeachers
  module RM6376
    module Admin
      class LotDataController < SupplyTeachers::Admin::FrameworkController
        include ::Admin::LotDataActions

        helper :telephone_number

        LOT_SORT_CRITERIA = 'lots.number'.freeze

        SECTIONS_TO_SHOW = %i[rates branches].freeze
        SECTIONS_TO_EDIT = %i[lot_status rates branches].freeze

        private

        def lot_sections(lot)
          %i[rates] + (lot.number == '1' ? %i[branches] : [])
        end
      end
    end
  end
end

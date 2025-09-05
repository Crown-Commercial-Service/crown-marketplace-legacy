module SupplyTeachers
  module Admin
    class LotDataController < SupplyTeachers::Admin::FrameworkController
      include ::Admin::LotDataController

      helper :telephone_number

      LOT_SORT_CRITERIA = 'lots.number'.freeze

      private

      def lot_sections(lot)
        %i[rates] + (lot.number == '1' ? %i[branches] : [])
      end
    end
  end
end

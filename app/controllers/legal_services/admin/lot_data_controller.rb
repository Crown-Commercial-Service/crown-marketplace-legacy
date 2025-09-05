module LegalServices
  module Admin
    class LotDataController < LegalServices::Admin::FrameworkController
      include ::Admin::LotDataController

      LOT_SORT_CRITERIA = 'lots.number'.freeze

      private

      def lot_sections(_lot)
        %i[services rates]
      end
    end
  end
end

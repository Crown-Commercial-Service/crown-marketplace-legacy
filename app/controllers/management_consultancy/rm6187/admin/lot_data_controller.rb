module ManagementConsultancy
  module RM6187
    module Admin
      class LotDataController < ManagementConsultancy::Admin::FrameworkController
        include ::Admin::LotDataController

        LOT_SORT_CRITERIA = 'lots.number::integer'.freeze

        private

        def lot_sections(_lot)
          %i[services rates]
        end
      end
    end
  end
end

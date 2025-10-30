module ManagementConsultancy
  module RM6309
    module Admin
      class LotDataController < ManagementConsultancy::Admin::FrameworkController
        include ::Admin::LotDataController

        LOT_SORT_CRITERIA = 'lots.number::integer'.freeze

        SECTIONS_TO_SHOW = %i[services rates].freeze
        SECTIONS_TO_EDIT = %i[lot_status].freeze

        private

        def lot_sections(_lot)
          %i[services rates]
        end
      end
    end
  end
end

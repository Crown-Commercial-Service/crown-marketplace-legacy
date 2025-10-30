module LegalServices
  module RM6240
    module Admin
      class LotDataController < LegalServices::Admin::LotDataController
        LOT_SORT_CRITERIA = 'lots.number'.freeze

        SECTIONS_TO_SHOW = %i[services rates].freeze

        private

        def lot_sections(_lot)
          %i[services rates]
        end
      end
    end
  end
end

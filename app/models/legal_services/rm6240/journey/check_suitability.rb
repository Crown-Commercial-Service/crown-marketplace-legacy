module LegalServices
  module RM6240
    class Journey::CheckSuitability < LegalServices::Journey::CheckSuitability
      def next_step_class
        case service_suitable
        when 'yes'
          Journey::SelectLot
        when 'no'
          Journey::Sorry
        end
      end
    end
  end
end

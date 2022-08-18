module LegalServices
  module RM3788
    class Journey::CheckSuitability < LegalServices::Journey::CheckSuitability
      def next_step_class
        case service_suitable
        when 'yes'
          Journey::ChooseServices
        when 'no'
          Journey::Sorry
        end
      end
    end
  end
end

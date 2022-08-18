module LegalServices
  module RM6240
    class Journey::ChooseServices < LegalServices::Journey::ChooseServices
      def services_for_lot(lot_number, _jurisdiction, central_government = 'no')
        central_government_options = if central_government == 'yes'
                                       [true]
                                     else
                                       [true, false]
                                     end

        LegalServices::RM6240::Service.where(lot_number: lot_number, central_government: central_government_options).sort_by(&:name)
      end

      def next_step_class
        Journey::ChooseJurisdiction
      end
    end
  end
end

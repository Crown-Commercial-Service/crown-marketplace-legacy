module LegalServices
  module RM3788
    class Journey::ChooseServices
      include Steppable

      attribute :lot
      attribute :services, Array
      validates :services, presence: true

      def services_for_lot(lot, jurisdiction, central_government = 'no')
        if lot == '2'
          LegalServices::RM3788::Service.where(lot_number: lot + jurisdiction).sort_by(&:name)
        else
          return LegalServices::RM3788::Service.where(lot_number: '1', central_government: 'yes').sort_by(&:name) if central_government == 'yes'

          LegalServices::RM3788::Service.where(lot_number: lot).sort_by(&:name)
        end
      end

      def selected_lot
        LegalServices::RM3788::Lot.find_by(number: lot)
      end

      def next_step_class
        case lot
        when '1'
          Journey::ChooseRegions
        else
          Journey::Suppliers
        end
      end
    end
  end
end

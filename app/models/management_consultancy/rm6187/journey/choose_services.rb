module ManagementConsultancy
  module RM6187
    class Journey::ChooseServices
      include Steppable

      attribute :services, Array
      validates :services, length: { minimum: 1 }

      def services_for_lot(lot_number)
        Service.where(lot_number:).sort_by(&:code)
      end

      def lot(lot_number)
        Lot.find_by(number: lot_number)
      end

      def next_step_class
        Journey::Suppliers
      end
    end
  end
end

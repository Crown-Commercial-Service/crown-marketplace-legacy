module ManagementConsultancy
  module RM6309
    class Journey::ChooseServices
      include Steppable

      attribute :services, Array
      validates :services, length: { minimum: 1 }

      def services_for_lot(lot_number)
        Service.where(lot_number:).sort_by(&:code)
      end

      def service_groups_for_lot(lot_number)
        Lot[lot_number].service_groups
      end

      def lot(lot_number)
        Lot[lot_number]
      end

      def next_step_class
        Journey::Suppliers
      end
    end
  end
end

module LegalServices
  module RM6374
    class Journey::SuppliersComparison
      include Steppable

      attribute :lot_number, :string

      def lot
        @lot ||= Lot.find("RM6374.#{lot_number}")
      end

      def supplier_frameworks
        @supplier_frameworks ||= ::Supplier::Framework.with_lots(lot.id).sort_by(&:supplier_name)
      end

    end
  end
end
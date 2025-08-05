module LegalPanelForGovernment
  module RM6360
    class Journey::Suppliers
      include Steppable

      def next_step_class
        Journey::SelectSuppliersForComparison
      end
    end
  end
end

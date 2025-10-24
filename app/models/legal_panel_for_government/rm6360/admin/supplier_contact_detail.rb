module LegalPanelForGovernment
  module RM6360
    module Admin
      class SupplierContactDetail < ::Supplier::Framework::ContactDetail
        self.table_name = 'supplier_framework_contact_details'

        ATTRIBUTES_TO_SKIP_VALIDATION = %i[name].freeze
      end
    end
  end
end

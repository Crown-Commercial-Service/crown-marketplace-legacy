module LegalPanelForGovernment
  module RM6360
    module Admin
      class SupplierContactDetail < ::Supplier::Framework::ContactDetail
        self.table_name = 'supplier_framework_contact_details'

        ATTRIBUTES_TO_SKIP_VALIDATION = %i[name managed_service_provider_name managed_service_provider_telephone managed_service_provider_email].freeze
      end
    end
  end
end

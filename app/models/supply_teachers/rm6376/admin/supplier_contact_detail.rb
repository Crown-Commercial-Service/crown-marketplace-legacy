module SupplyTeachers
  module RM6376
    module Admin
      class SupplierContactDetail < ::Supplier::Framework::ContactDetail
        self.table_name = 'supplier_framework_contact_details'

        ATTRIBUTES_TO_VALIDATE = %i[website managed_service_provider_name managed_service_provider_telephone managed_service_provider_email].freeze
      end
    end
  end
end

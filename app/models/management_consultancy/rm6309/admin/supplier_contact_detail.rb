module ManagementConsultancy
  module RM6309
    module Admin
      class SupplierContactDetail < ::Supplier::Framework::ContactDetail
        self.table_name = 'supplier_framework_contact_details'

        ATTRIBUTES_TO_VALIDATE = %i[name email telephone_number website address].freeze
      end
    end
  end
end

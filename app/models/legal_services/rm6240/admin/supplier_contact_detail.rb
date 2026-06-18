module LegalServices
  module RM6240
    module Admin
      class SupplierContactDetail < ::Supplier::Framework::ContactDetail
        self.table_name = 'supplier_framework_contact_details'

        ATTRIBUTES_TO_VALIDATE = %i[email telephone_number website address lot_1_prospectus_link lot_2_prospectus_link lot_3_prospectus_link].freeze
      end
    end
  end
end

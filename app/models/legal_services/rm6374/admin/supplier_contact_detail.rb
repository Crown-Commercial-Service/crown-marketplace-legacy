module LegalServices
  module RM6374
    module Admin
      class SupplierContactDetail < ::Supplier::Framework::ContactDetail
        self.table_name = 'supplier_framework_contact_details'

        ATTRIBUTES_TO_VALIDATE = %i[email telephone_number website address description lot_1_prospectus_link lot_1a_prospectus_link lot_1b_prospectus_link lot_1c_prospectus_link lot_2_prospectus_link lot_3_prospectus_link lot_4_prospectus_link lot_5_prospectus_link lot_6_prospectus_link].freeze
      end
    end
  end
end

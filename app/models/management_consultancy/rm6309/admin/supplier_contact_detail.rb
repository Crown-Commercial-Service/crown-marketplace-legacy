module ManagementConsultancy
  module RM6309
    module Admin
      class SupplierContactDetail < ::Supplier::Framework::ContactDetail
        self.table_name = 'supplier_framework_contact_details'

        ATTRIBUTES_TO_SKIP_VALIDATION = %i[lot_1_prospectus_link lot_2_prospectus_link lot_3_prospectus_link lot_4a_prospectus_link lot_4b_prospectus_link lot_4c_prospectus_link lot_5_prospectus_link].freeze
      end
    end
  end
end

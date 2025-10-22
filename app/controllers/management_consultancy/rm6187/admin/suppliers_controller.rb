module ManagementConsultancy
  module RM6187
    module Admin
      class SuppliersController < ManagementConsultancy::Admin::FrameworkController
        include ::Admin::SuppliersController

        SECTION_TO_PARAMS = {
          basic_supplier_information: %i[name duns_number sme],
          supplier_contact_information: %i[name email telephone_number website],
          additional_supplier_information: %i[address]
        }.freeze
      end
    end
  end
end

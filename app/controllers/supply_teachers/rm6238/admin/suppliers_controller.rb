module SupplyTeachers
  module RM6238
    module Admin
      class SuppliersController < SupplyTeachers::Admin::SuppliersController
        SECTION_TO_PARAMS = {
          basic_supplier_information: %i[name],
        }.freeze
      end
    end
  end
end

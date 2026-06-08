module SupplyTeachers
  module RM6238
    module Admin
      class SuppliersController < SupplyTeachers::Admin::FrameworkController
        include ::Admin::SupplierActions
        include SectionsConcern
      end
    end
  end
end

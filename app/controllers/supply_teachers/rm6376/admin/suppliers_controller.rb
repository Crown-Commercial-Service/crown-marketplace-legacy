module SupplyTeachers
  module RM6376
    module Admin
      class SuppliersController < SupplyTeachers::Admin::FrameworkController
        include ::Admin::SupplierActions
        include SectionsConcern
      end
    end
  end
end

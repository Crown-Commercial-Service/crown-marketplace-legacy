module ManagementConsultancy
  module RM6309
    module Admin
      class SuppliersController < ManagementConsultancy::Admin::FrameworkController
        include ::Admin::SupplierActions
        include SectionsConcern
      end
    end
  end
end

module ManagementConsultancy
  module RM6309
    module Admin
      class SuppliersController < ManagementConsultancy::Admin::FrameworkController
        include ::Admin::SuppliersController
        include SectionsConcern
      end
    end
  end
end

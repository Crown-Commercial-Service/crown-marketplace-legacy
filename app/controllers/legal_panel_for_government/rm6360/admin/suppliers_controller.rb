module LegalPanelForGovernment
  module RM6360
    module Admin
      class SuppliersController < LegalPanelForGovernment::Admin::FrameworkController
        include ::Admin::SupplierActions
        include SectionsConcern
      end
    end
  end
end

module LegalServices
  module RM6374
    module Admin
      class SuppliersController < LegalServices::Admin::FrameworkController
        include ::Admin::SupplierActions
        include SectionsConcern
      end
    end
  end
end

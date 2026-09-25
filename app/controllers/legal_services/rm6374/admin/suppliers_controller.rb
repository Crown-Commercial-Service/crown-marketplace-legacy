module LegalServices
  module RM6374
    module Admin
      class SuppliersController < LegalServices::Admin::FrameworkController
        include ::Admin::SupplierActions
        include SectionsConcern

        def show
          render 'legal_services/rm6374/admin/suppliers/show'
        end

      end
    end
  end
end
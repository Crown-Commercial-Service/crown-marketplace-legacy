module LegalServices
  module RM6240
    module Admin
      class Upload < LegalServices::Admin::Upload
        self.table_name = 'legal_services_rm6240_admin_uploads'

        ATTRIBUTES = SHARED_ATTRIBUTES
      end
    end
  end
end

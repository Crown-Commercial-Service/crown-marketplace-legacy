module LegalServices
  module RM3788
    module Admin
      class PasswordsController < Base::PasswordsController
        protected

        def new_password_path
          legal_services_rm3788_admin_new_user_password_path
        end

        def after_password_reset_path
          legal_services_rm3788_admin_password_reset_success_path
        end

        def after_request_password_path
          legal_services_rm3788_admin_edit_user_password_path
        end
      end
    end
  end
end

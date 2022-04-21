module ManagementConsultancy
  module RM6187
    class PasswordsController < Base::PasswordsController
      protected

      def new_password_path
        management_consultancy_rm6187_new_user_password_path
      end

      def after_password_reset_path
        management_consultancy_rm6187_password_reset_success_path
      end

      def after_request_password_path
        management_consultancy_rm6187_edit_user_password_path
      end
    end
  end
end

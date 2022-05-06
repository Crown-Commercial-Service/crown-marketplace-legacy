module SupplyTeachers
  module RM3826
    class PasswordsController < Base::PasswordsController
      protected

      def new_password_path
        supply_teachers_rm3826_new_user_password_path
      end

      def after_password_reset_path
        supply_teachers_rm3826_password_reset_success_path
      end

      def after_request_password_path
        supply_teachers_rm3826_edit_user_password_path
      end
    end
  end
end

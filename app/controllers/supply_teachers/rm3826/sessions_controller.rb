module SupplyTeachers
  module RM3826
    class SessionsController < Base::SessionsController
      protected

      def service_challenge_path
        supply_teachers_rm3826_users_challenge_path(challenge_name: @result.challenge_name)
      end

      def after_sign_in_path_for(resource)
        stored_location_for(resource) || supply_teachers_journey_start_path
      end

      def after_sign_out_path_for(_resource)
        supply_teachers_journey_start_path
      end

      def new_session_path
        supply_teachers_rm3826_new_user_session_path
      end

      def confirm_forgot_password_path
        supply_teachers_rm3826_edit_user_password_path
      end

      def confirm_email_path
        supply_teachers_rm3826_users_confirm_path
      end
    end
  end
end

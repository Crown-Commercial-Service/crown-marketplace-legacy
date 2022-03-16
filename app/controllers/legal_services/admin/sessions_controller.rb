module LegalServices
  module Admin
    class SessionsController < Base::SessionsController
      protected

      def service_challenge_path
        legal_services_admin_users_challenge_path(challenge_name: @result.challenge_name)
      end

      def after_sign_in_path_for(resource)
        stored_location_for(resource) || legal_services_admin_uploads_path
      end

      def after_sign_out_path_for(_resource)
        legal_services_admin_uploads_path
      end

      def new_session_path
        legal_services_admin_new_user_session_path
      end

      def confirm_forgot_password_path
        legal_services_admin_edit_user_password_path
      end
    end
  end
end

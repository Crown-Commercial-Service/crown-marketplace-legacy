module LegalServices
  module RM3788
    class UsersController < Base::UsersController
      private

      def new_service_challenge_path
        legal_services_rm3788_users_challenge_path(challenge_name: @challenge.new_challenge_name)
      end

      def after_sign_in_path_for(resource)
        stored_location_for(resource) || legal_services_journey_start_path
      end

      def confirm_user_registration_path
        legal_services_rm3788_users_confirm_path
      end
    end
  end
end

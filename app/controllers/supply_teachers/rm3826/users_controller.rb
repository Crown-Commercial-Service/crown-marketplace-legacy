module SupplyTeachers
  module RM3826
    class UsersController < Base::UsersController
      private

      def new_service_challenge_path
        supply_teachers_rm3826_users_challenge_path(challenge_name: @challenge.new_challenge_name)
      end

      def after_sign_in_path_for(resource)
        stored_location_for(resource) || supply_teachers_journey_start_path
      end

      def confirm_user_registration_path
        supply_teachers_rm3826_users_confirm_path
      end
    end
  end
end

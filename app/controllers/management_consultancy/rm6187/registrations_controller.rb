module ManagementConsultancy
  module RM6187
    class RegistrationsController < Base::RegistrationsController
      private

      def mc_access
        :mc_access
      end

      def service_after_sign_up_path
        management_consultancy_rm6187_users_confirm_path
      end

      def domain_not_on_safelist_path
        management_consultancy_rm6187_domain_not_on_safelist_path
      end
    end
  end
end

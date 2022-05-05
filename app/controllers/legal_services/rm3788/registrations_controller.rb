module LegalServices
  module RM3788
    class RegistrationsController < Base::RegistrationsController
      private

      def ls_access
        :ls_access
      end

      def service_after_sign_up_path
        legal_services_rm3788_users_confirm_path
      end

      def domain_not_on_safelist_path
        legal_services_rm3788_domain_not_on_safelist_path
      end
    end
  end
end

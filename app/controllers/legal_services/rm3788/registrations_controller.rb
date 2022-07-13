module LegalServices
  module RM3788
    class RegistrationsController < Base::RegistrationsController
      private

      def ls_access
        :ls_access
      end
    end
  end
end

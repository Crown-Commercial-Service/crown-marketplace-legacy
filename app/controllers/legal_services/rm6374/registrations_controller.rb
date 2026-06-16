module LegalServices
  module RM6374
    class RegistrationsController < Base::RegistrationsController
      include LegalServices::FrameworkStatusConcern

      private

      def ls_access
        :ls_access
      end
    end
  end
end

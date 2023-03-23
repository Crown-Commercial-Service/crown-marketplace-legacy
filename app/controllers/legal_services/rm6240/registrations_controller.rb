module LegalServices
  module RM6240
    class RegistrationsController < Base::RegistrationsController
      include LegalServices::FrameworkStatusConcern

      private

      def ls_access
        :ls_access
      end
    end
  end
end

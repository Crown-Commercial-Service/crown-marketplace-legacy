module LegalPanelForGovernment
  module RM6360
    class RegistrationsController < Base::RegistrationsController
      include LegalPanelForGovernment::FrameworkStatusConcern

      private

      def ls_access
        :ls_access
      end
    end
  end
end

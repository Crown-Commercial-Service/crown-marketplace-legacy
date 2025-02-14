module ManagementConsultancy
  module RM6309
    class RegistrationsController < Base::RegistrationsController
      include ManagementConsultancy::FrameworkStatusConcern

      private

      def mc_access
        :mc_access
      end
    end
  end
end

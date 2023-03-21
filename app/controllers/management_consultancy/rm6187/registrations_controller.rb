module ManagementConsultancy
  module RM6187
    class RegistrationsController < Base::RegistrationsController
      include ManagementConsultancy::FrameworkStatusConcern

      private

      def mc_access
        :mc_access
      end
    end
  end
end

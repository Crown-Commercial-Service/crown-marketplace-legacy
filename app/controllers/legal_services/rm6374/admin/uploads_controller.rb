module LegalServices
  module RM6374
    module Admin
      class UploadsController < LegalServices::Admin::FrameworkController
        include ::Admin::UploadActions

        private

        def service_key
          :ls
        end
      end
    end
  end
end

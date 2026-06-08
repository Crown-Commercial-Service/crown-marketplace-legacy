module LegalServices
  module RM6240
    module Admin
      class FrameworksController < LegalServices::Admin::FrameworkController
        include ::Admin::FrameworkActions
      end
    end
  end
end

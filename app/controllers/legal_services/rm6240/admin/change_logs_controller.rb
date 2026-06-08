module LegalServices
  module RM6240
    module Admin
      class ChangeLogsController < LegalServices::Admin::FrameworkController
        include ::Admin::ChangeLogActions
        include SectionsConcern
      end
    end
  end
end

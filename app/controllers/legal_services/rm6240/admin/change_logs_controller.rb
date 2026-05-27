module LegalServices
  module RM6240
    module Admin
      class ChangeLogsController < LegalServices::Admin::ChangeLogsController
        include SectionsConcern
      end
    end
  end
end

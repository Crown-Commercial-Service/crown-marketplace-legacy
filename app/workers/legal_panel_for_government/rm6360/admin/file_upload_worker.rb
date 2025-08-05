module LegalPanelForGovernment
  module RM6360
    module Admin
      class FileUploadWorker < ::Admin::FileUploadWorker
        sidekiq_options queue: 'lpg', retry: false
      end
    end
  end
end

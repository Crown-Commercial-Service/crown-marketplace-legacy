module LegalServices
  module RM6240
    module Admin
      class FileUploadWorker < ::Admin::FileUploadWorker
        sidekiq_options queue: 'ls', retry: false
      end
    end
  end
end

module LegalServices
  module RM6374
    class FileUploadWorker < ::Admin::FileUploadWorker
      sidekiq_options queue: 'ls', retry: false
    end
  end
end

module ManagementConsultancy
  module RM6309
    module Admin
      class FileUploadWorker < ::Admin::FileUploadWorker
        sidekiq_options queue: 'mc', retry: false
      end
    end
  end
end

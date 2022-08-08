module ManagementConsultancy
  module RM6187
    module Admin
      class FileUploadWorker < ::Admin::FileUploadWorker
        sidekiq_options queue: 'mc', retry: false
      end
    end
  end
end

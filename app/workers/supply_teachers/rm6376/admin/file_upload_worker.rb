module SupplyTeachers
  module RM6376
    module Admin
      class FileUploadWorker < ::Admin::FileUploadWorker
        sidekiq_options queue: 'st', retry: false
      end
    end
  end
end

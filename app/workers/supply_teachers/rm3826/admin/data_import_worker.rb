module SupplyTeachers
  module RM3826
    module Admin
      class DataImportWorker
        include Sidekiq::Worker
        sidekiq_options queue: 'st'

        def perform(upload_id)
          upload = Admin::Upload.find(upload_id)
          DataImport.new(upload).import_data
        rescue ActiveRecord::RecordNotFound => e
          logger.error e.message
        end
      end
    end
  end
end

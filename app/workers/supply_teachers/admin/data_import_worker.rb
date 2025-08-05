module SupplyTeachers
  module Admin
    class DataImportWorker
      include Sidekiq::Worker

      sidekiq_options queue: 'st'

      def perform(upload_id)
        upload = self.class.module_parent::Upload.find(upload_id)
        self.class.module_parent::DataImport.new(upload).import_data
      rescue ActiveRecord::RecordNotFound => e
        logger.error e.message
      end
    end
  end
end

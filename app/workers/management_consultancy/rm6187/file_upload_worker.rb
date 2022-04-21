module ManagementConsultancy
  module RM6187
    class FileUploadWorker
      include Sidekiq::Worker
      sidekiq_options queue: 'mc', retry: false

      def perform(id)
        mc_import = Admin::Upload.find(id)
        FilesImporter.new(mc_import).import_data
      rescue ActiveRecord::RecordNotFound => e
        logger.error e.message
      end
    end
  end
end

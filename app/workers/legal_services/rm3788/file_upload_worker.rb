module LegalServices
  module RM3788
    class FileUploadWorker
      include Sidekiq::Worker
      sidekiq_options queue: 'ls', retry: false

      def perform(id)
        ls_import = Admin::Upload.find(id)
        FilesImporter.new(ls_import).import_data
      rescue ActiveRecord::RecordNotFound => e
        logger.error e.message
      end
    end
  end
end

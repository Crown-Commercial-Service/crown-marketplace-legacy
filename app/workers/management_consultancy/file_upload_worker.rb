module ManagementConsultancy
  class FileUploadWorker
    include Sidekiq::Worker
    sidekiq_options queue: 'mc', retry: false

    def perform(id)
      mc_import = ManagementConsultancy::Admin::Upload.find(id)
      ManagementConsultancy::FilesImporter.new(mc_import).import_data
    rescue ActiveRecord::RecordNotFound => e
      logger.error e.message
    end
  end
end

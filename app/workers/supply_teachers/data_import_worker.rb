require 'rake'
require 'aws-sdk-s3'

module SupplyTeachers
  class DataImportWorker
    include Sidekiq::Worker
    sidekiq_options queue: 'st'

    def perform(upload_id)
      upload = SupplyTeachers::Admin::Upload.find(upload_id)
      SupplyTeachers::DataImport.new(upload).import_data
    rescue ActiveRecord::RecordNotFound => e
      logger.error e.message
    end
  end
end

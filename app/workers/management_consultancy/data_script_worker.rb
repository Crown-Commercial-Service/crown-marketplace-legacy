require 'rake'
require 'aws-sdk-s3'

module ManagementConsultancy
  class DataScriptWorker
    include Sidekiq::Worker
    sidekiq_options queue: 'mc'

    def perform(upload_id)
      @upload = ManagementConsultancy::Admin::Upload.find(upload_id)
      Rake::Task.clear
      Rails.application.load_tasks
      Rake::Task['mc:clean'].invoke
      Rake::Task['mc:data'].invoke

      check_for_errors
    rescue StandardError => e
      fail_upload(@upload, e.full_message)
    end

    private

    def check_for_errors
      Rails.env.development? ? check_local_errors_out : check_s3_errors_out
    end

    def check_local_errors_out
      error_file_path = Rails.root.join('storage', 'management_consultancy', 'current_data', 'output', 'errors.out')
      if File.zero?(error_file_path)
        @upload.review!
      else
        file = File.open(error_file_path)
        fail_upload(@upload, file.read)
      end
    end

    def check_s3_errors_out
      error_file_path = 'management_consultancy/current_data/output/errors.out'
      object = Aws::S3::Resource.new(region: ENV['COGNITO_AWS_REGION'])
      if object.bucket(ENV['CCS_APP_API_DATA_BUCKET']).object(error_file_path).exists?
        file = URI.open("https://s3-#{ENV['COGNITO_AWS_REGION']}.amazonaws.com/#{ENV['CCS_APP_API_DATA_BUCKET']}/#{error_file_path}")
        fail_upload(@upload, file.read)
      else
        @upload.review!
      end
    end

    def fail_upload(upload, fail_reason)
      upload.fail!
      upload.update(fail_reason: fail_reason)
    end
  end
end

module SupplyTeachers
  module RM3826
    class DataUploadWorker
      include Sidekiq::Worker
      sidekiq_options queue: 'st'

      def perform(upload_id)
        upload = Admin::Upload.find(upload_id)

        tmpfile = Tempfile.create
        begin
          tmpfile.binmode
          tmpfile.write Admin::CurrentData.first.data.download
          suppliers = JSON.parse(File.read(tmpfile.path))
        ensure
          tmpfile.close
        end

        Upload.upload!(suppliers)

        upload.publish!
      rescue ActiveRecord::RecordInvalid => e
        summary = {
          record: e.record,
          record_class: e.record.class.to_s,
          errors: e.record.errors
        }

        fail_upload(Admin::Upload.find(upload_id), summary)
      end

      private

      def fail_upload(upload, fail_reason)
        upload.fail!
        upload.update(fail_reason: fail_reason)
      end
    end
  end
end

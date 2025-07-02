module SupplyTeachers
  module Admin
    class DataUploadWorker
      include Sidekiq::Worker
      sidekiq_options queue: 'st'

      # rubocop:disable Metrics/AbcSize
      def perform(upload_id)
        upload = admin_upload_module.find(upload_id)

        tmpfile = Tempfile.create
        begin
          tmpfile.binmode
          tmpfile.write current_data_module.first.data.download
          suppliers = JSON.parse(File.read(tmpfile.path))
        ensure
          tmpfile.close
        end

        ::Upload.smart_upload!(framework_id, data_converter_module.convert_data(suppliers))

        upload.publish!
      rescue ActiveRecord::RecordInvalid => e
        summary = {
          record: e.record,
          record_class: e.record.class.to_s,
          errors: e.record.errors
        }

        fail_upload(admin_upload_module.find(upload_id), summary)
      end
      # rubocop:enable Metrics/AbcSize

      private

      def fail_upload(upload, fail_reason)
        upload.fail!
        upload.update(fail_reason:)
      end

      def admin_upload_module
        self.class.module_parent::Upload
      end

      def current_data_module
        self.class.module_parent::CurrentData
      end

      def data_converter_module
        self.class.module_parent::DataConverter
      end

      def framework_id
        self.class.to_s.split('::')[1]
      end
    end
  end
end

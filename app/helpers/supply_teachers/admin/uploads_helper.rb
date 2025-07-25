module SupplyTeachers::Admin::UploadsHelper
  def warning_details(uploads)
    sessions = uploads.map(&:short_uuid).to_sentence
    states = uploads.map { |upload| t("supply_teachers.admin.uploads.state.#{upload.aasm_state}") }.to_sentence.downcase

    if uploads.many?
      t('supply_teachers.admin.uploads.new.warning_plural', sessions:, states:)
    else
      t('supply_teachers.admin.uploads.new.warning_singular', session: sessions, state: states)
    end
  end

  def upload_status_tag(status)
    colour = case status
             when 'published', 'files_processed'
               nil
             when 'failed', 'rejected', 'canceled'
               :red
             else
               :grey
             end

    [t("supply_teachers.admin.uploads.state.#{status}"), colour]
  end

  def expected_file_type(attachment)
    t("supply_teachers.admin.uploads.new.extension_type.#{service::Upload::FILE_TO_EXTENSION[attachment]}")
  end
end

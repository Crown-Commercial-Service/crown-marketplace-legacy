module ManagementConsultancy::Admin::UploadsHelper
  def upload_status_tag(status)
    case status
    when 'published'
      [:blue, 'published on live']
    when 'failed'
      [:red, 'failed']
    else
      [:grey, 'in progress']
    end
  end

  def template_file_path
    Marketplace.mcf3_live? ? t('management_consultancy.admin.uploads.new.template_file_mcf3_path') : t('management_consultancy.admin.uploads.new.template_file_path')
  end

  def error_translation_base
    @error_translation_base ||= Marketplace.mcf3_live? ? '.error_details.mcf3_live' : '.error_details'
  end
end

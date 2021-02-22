module ManagementConsultancy::Admin::UploadsHelper
  def css_classes_for_file_upload(journey, attribute, extra_classes = [])
    error = journey.errors[attribute].first

    css_classes = ['govuk-file-upload'] + extra_classes
    css_classes += %w[govuk-input--error govuk-input] if error.present?
    css_classes
  end

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

  def current_files_for_upload
    Marketplace.mcf3_live? ? %i[supplier_details_file supplier_rate_cards_file supplier_service_offerings_file] : %i[supplier_details_file supplier_rate_cards_file supplier_regional_offerings_file supplier_service_offerings_file]
  end

  def error_translation_base
    @error_translation_base ||= Marketplace.mcf3_live? ? '.error_details.mcf3_live' : '.error_details'
  end

  def get_error_details(error, details)
    t("management_consultancy.admin.uploads.failed.error_details.#{error}_html", list: details_to_list(details))
  end

  def details_to_list(details)
    tag.ul class: 'govuk-list govuk-list--bullet' do
      details.each do |detail|
        concat(tag.li(detail))
      end
    end
  end
end

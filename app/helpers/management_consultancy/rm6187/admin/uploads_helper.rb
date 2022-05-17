module ManagementConsultancy::RM6187::Admin::UploadsHelper
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
end

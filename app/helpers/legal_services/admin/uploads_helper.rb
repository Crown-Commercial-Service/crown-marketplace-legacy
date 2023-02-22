module LegalServices::Admin::UploadsHelper
  def upload_status_tag(status)
    case status
    when 'published'
      ['published on live']
    when 'failed'
      ['failed', :red]
    else
      ['in progress', :grey]
    end
  end
end

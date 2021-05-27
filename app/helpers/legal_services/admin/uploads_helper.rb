module LegalServices::Admin::UploadsHelper
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

  def get_error_details(error, details)
    t("legal_services.admin.uploads.failed.error_details.#{error}_html", list: details_to_list(details))
  end

  def details_to_list(details)
    tag.ul class: 'govuk-list govuk-list--bullet' do
      details.each do |detail|
        concat(tag.li(DETAIL_TO_SHEET_NAME[detail.to_sym] || detail))
      end
    end
  end

  DETAIL_TO_SHEET_NAME = { '1': 'Lot 1', '2a': 'Lot 2a - England & Wales', '2b': 'Lot 2b - Scotland', '2c': 'Lot 2c - Northern Ireland', '3': 'Lot 3', '4': 'Lot 4',
                           'full_uk': 'Full UK Coverage', 'nuts_c': 'North East England (NUTS C)', 'nuts_d': 'North West England (NUTS D)', 'nuts_e': 'Yorkshire & Humberside (NUTS E)', 'nuts_f': 'East Midlands (NUTS F)', 'nuts_g': 'West Midlands (NUTS G)', 'nuts_h': 'East of England (NUTS H)', 'nuts_i': 'Greater London (NUTS I)', 'nuts_j': 'South East England (NUTS J)', 'nuts_k': 'South West England (NUTS K)', 'nuts_l': 'Wales (NUTS L)', 'nuts_m': 'Scotland (NUTS M)', 'nuts_n': 'Northern Ireland (NUTS N)',
                           'a': 'Lot 2a - England & Wales', 'b': 'Lot 2b - Scotland', 'c': 'Lot 2c - Northern Ireland' }.freeze
end

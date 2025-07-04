module LegalServices::SuppliersHelper
  def full_lot_name(lot)
    "Lot #{lot.number} - #{lot.name}"
  end

  def prospectus_link_present?
    prospectus_link.present? && prospectus_link.downcase != 'n/a'
  end

  def prospectus_link_a_url?
    URI.parse(prospectus_link)
    true
  rescue StandardError
    false
  end

  def prospectus_link
    @prospectus_link ||= @supplier_framework.contact_detail.additional_details["lot_#{@lot.number}_prospectus_link"]
  end
end

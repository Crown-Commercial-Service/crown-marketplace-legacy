module LegalServices::SuppliersHelper
  def full_lot_name(lot)
    "Lot #{lot.number[0]} - #{lot.name}"
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

  def prospectus_link_for_list_page(supplier_framework)
    @prospectus_links ||= {}
    @prospectus_links[supplier_framework.id] ||= fetch_valid_prospectus_url(supplier_framework)
  end

  private

  def fetch_valid_prospectus_url(supplier_framework)
    url = supplier_framework.contact_detail&.additional_details&.fetch("lot_#{@lot.number}_prospectus_link", nil).to_s
    return nil if url.blank? || url.casecmp('n/a').zero?

    URI.parse(url)
    url
  rescue StandardError
    nil
  end
end

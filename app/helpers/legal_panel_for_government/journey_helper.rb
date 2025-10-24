module LegalPanelForGovernment::JourneyHelper
  def lot_full_name(lot)
    t('legal_panel_for_government.journey.lot_full_name', lot_number: lot.number, lot_name: lot.name)
  end

  def lot_legal_specialisms(lot)
    t('legal_panel_for_government.journey.lot_legal_specialisms', lot_number: lot.number)
  end

  def prospectus_link_present?(supplier_framework, lot)
    prospectus_link(supplier_framework, lot).present? && prospectus_link(supplier_framework, lot).downcase != 'n/a'
  end

  def prospectus_link_a_url?(supplier_framework, lot)
    URI.parse(prospectus_link(supplier_framework, lot))
    true
  rescue StandardError
    false
  end

  def prospectus_link(supplier_framework, lot)
    (@prospectus_link ||= {})[supplier_framework.id] ||= supplier_framework.contact_detail.additional_details["lot_#{lot.number}_prospectus_link"]
  end
end

module LegalPanelForGovernment::RM6360::SuppliersHelper
  include LegalPanelForGovernment::RM6360::RatesHelper

  def full_lot_name(lot)
    "Lot #{lot.number} - #{lot.name}"
  end

  def prospectus_link_present?(supplier_framework)
    prospectus_link(supplier_framework).present? && prospectus_link(supplier_framework).downcase != 'n/a'
  end

  def prospectus_link_a_url?(supplier_framework)
    URI.parse(prospectus_link(supplier_framework))
    true
  rescue StandardError
    false
  end

  def prospectus_link(supplier_framework)
    (@prospectus_link ||= {})[supplier_framework.id] ||= supplier_framework.contact_detail.additional_details["lot_#{@lot.number}_prospectus_link"]
  end

  def download_legal_panel_for_government_suppliers_path
    download_legal_panel_for_government_rm6360_suppliers_path(
      lot_id: params[:lot_id],
      service_ids: params[:service_ids],
      not_core_jurisdiction: params[:not_core_jurisdiction],
      jurisdiction_ids: params[:jurisdiction_ids]
    )
  end

  def legal_panel_for_government_path(supplier)
    legal_panel_for_government_rm6360_supplier_path(supplier, lot_id: params[:lot_id], service_ids: params[:service_ids], not_core_jurisdiction: params[:not_core_jurisdiction], jurisdiction_ids: params[:jurisdiction_ids])
  end
end

module LegalServices::RM6240::SuppliersHelper
  include LegalServices::SuppliersHelper

  def download_legal_services_suppliers_path
    download_legal_services_rm6240_suppliers_path(
      lot: params[:lot],
      services: params[:services],
      jurisdiction: params[:jurisdiction],
      central_government: params[:central_government]
    )
  end

  def legal_services_supplier_path(supplier)
    legal_services_rm6240_supplier_path(supplier, lot: params[:lot], jurisdiction: params[:jurisdiction])
  end

  def display_rate(position)
    found_rate = @rate_card.find { |rate| rate.position == position }

    return if found_rate.nil? || found_rate.rate.zero?

    number_to_currency(found_rate.value, precision: 2)
  end
end

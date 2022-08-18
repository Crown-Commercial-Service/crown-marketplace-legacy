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
    number_to_currency(@rate_card.find { |rate| rate.position == position }.value, precision: 2)
  end
end

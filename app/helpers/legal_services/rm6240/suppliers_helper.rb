module LegalServices::RM6240::SuppliersHelper
  include LegalServices::SuppliersHelper
  include LegalServices::RatesHelper

  def download_legal_services_suppliers_path
    download_legal_services_rm6240_suppliers_path(
      lot_number: params[:lot_number],
      service_numbers: params[:service_numbers],
      jurisdiction: params[:jurisdiction],
      central_government: params[:central_government]
    )
  end

  def legal_services_supplier_path(supplier)
    legal_services_rm6240_supplier_path(supplier, lot_number: params[:lot_number], service_numbers: params[:service_numbers], jurisdiction: params[:jurisdiction])
  end
end

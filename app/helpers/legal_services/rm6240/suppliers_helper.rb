module LegalServices::RM6240::SuppliersHelper
  include LegalServices::SuppliersHelper

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

  def legal_service_position_ids
    (1..7)
  end

  def display_rate(position_id)
    return if @rates[position_id].nil? || @rates[position_id].rate.zero?

    number_to_currency(@rates[position_id].rate_in_pounds, precision: 2)
  end
end

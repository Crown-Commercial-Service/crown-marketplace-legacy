module LegalServices::RM6240::SuppliersHelper
  include LegalServices::SuppliersHelper

  def download_legal_services_suppliers_path
    download_legal_services_rm6240_suppliers_path(
      lot_id: params[:lot_id],
      service_ids: params[:service_ids],
      jurisdiction_id: params[:jurisdiction_id],
      central_government: params[:central_government]
    )
  end

  def legal_services_supplier_path(supplier)
    legal_services_rm6240_supplier_path(supplier, lot_id: params[:lot_id], jurisdiction_id: params[:jurisdiction_id])
  end

  def legal_service_position_ids
    (1..7)
  end

  def display_rate(position_id)
    return if @rates[position_id].nil? || @rates[position_id].rate.zero?

    number_to_currency(@rates[position_id].rate_in_pounds, precision: 2)
  end
end

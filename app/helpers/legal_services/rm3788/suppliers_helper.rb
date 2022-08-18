module LegalServices::RM3788::SuppliersHelper
  include LegalServices::SuppliersHelper

  def download_legal_services_suppliers_path
    download_legal_services_rm3788_suppliers_path(
      lot: params[:lot],
      services: params[:services],
      region_codes: params[:region_codes],
      jurisdiction: params[:jurisdiction],
      central_government: params[:central_government]
    )
  end

  def legal_services_supplier_path(supplier)
    legal_services_rm3788_supplier_path(supplier, lot: params[:lot], jurisdiction: params[:jurisdiction])
  end

  def positions
    %w[managing senior solicitor junior trainee]
  end

  def display_rate(position, time)
    number_to_currency(@rate_card[position][time] / 100.0, precision: 2)
  end
end

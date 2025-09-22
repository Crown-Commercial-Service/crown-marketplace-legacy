module LegalServices::Admin::LotDataHelper
  include Admin::LotDataHelper
  include LegalServices::RatesHelper

  def services_lot_title(supplier_lot_data_item)
    if supplier_lot_data_item[:lot][:number] == '3'
      super
    else
      t(
        'legal_services.admin.lot_data.index.supplier_lot_data_summary_list.lot_name',
        jurisdiction: t("legal_services.admin.lot_data.index.jurisdictions.#{supplier_lot_data_item[:lot][:number][1]}"),
        **supplier_lot_data_item[:lot]
      )
    end
  end
end

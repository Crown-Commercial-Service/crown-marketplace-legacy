module Admin::LotDataHelper
  def services_lot_title(supplier_lot_data_item)
    t('shared.admin.lot_data.index.supplier_lot_data_summary_list.lot_name', **supplier_lot_data_item[:lot])
  end

  def enabled_status_tag(is_enabled)
    if is_enabled
      [t('shared.admin.lot_data.index.enabled.active')]
    else
      [t('shared.admin.lot_data.index.enabled.inactive'), :red]
    end
  end
end

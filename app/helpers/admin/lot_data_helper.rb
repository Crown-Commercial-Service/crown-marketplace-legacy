module Admin::LotDataHelper
  def enabled_status_tag(is_enabled)
    if is_enabled
      [t('shared.admin.lot_data.index.enabled.active')]
    else
      [t('shared.admin.lot_data.index.enabled.inactive'), :red]
    end
  end
end

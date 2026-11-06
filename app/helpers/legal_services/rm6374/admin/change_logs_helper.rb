module LegalServices::RM6374::Admin::ChangeLogsHelper
  include Admin::ChangeLogsHelper

  def additional_change_log_summary
    summary_list_items = []

    unless exclude_section_from_summary?(@change_log.change_type, :upload_supplier_data)
      summary_list_items << build_summary_item(
        t('shared.admin.change_logs.show.summary_list.supplier_name'),
        @change_log.change_data['supplier_name']
      )
    end

    if include_section_in_summary?(@change_log.change_type, *%i[update_supplier_framework_lot_status update_supplier_framework_lot_services update_supplier_framework_lot_rates update_supplier_framework_lot_jurisdictions update_supplier_framework_lot_branch add_rates_for_supplier_framework_lot_jurisdiction remove_rates_for_supplier_framework_lot_jurisdiction])
      lot = Lot.find(@change_log.change_data['lot_id'])

      summary_list_items << build_summary_item(
        t('shared.admin.change_logs.show.summary_list.lot'),
        t('shared.admin.change_logs.show.lot_name', number: lot.number, name: lot.name)
      )
    end

    summary_list_items
  end
end

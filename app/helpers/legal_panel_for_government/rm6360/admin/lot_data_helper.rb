module LegalPanelForGovernment::RM6360::Admin::LotDataHelper
  include Admin::LotDataHelper
  include LegalPanelForGovernment::RM6360::RatesHelper

  def edit_page_heading
    @edit_page_heading ||= if @section == :rates
                             t('shared.admin.lot_data.edit.heading.heading_with_country', section: t(".heading.#{@section}"), country: @supplier_framework_lot_jurisdiction.jurisdiction.name)
                           else
                             super
                           end
  end
end

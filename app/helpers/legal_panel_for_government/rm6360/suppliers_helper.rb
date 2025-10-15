module LegalPanelForGovernment::RM6360::SuppliersHelper
  include LegalPanelForGovernment::JourneyHelper
  include LegalPanelForGovernment::RM6360::RatesHelper

  def legal_panel_for_government_path(supplier)
    legal_panel_for_government_rm6360_supplier_path(supplier, **@journey.params)
  end
end

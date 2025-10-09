module LegalPanelForGovernment::JourneyHelper
  def lot_full_name(lot)
    t('legal_panel_for_government.journey.lot_full_name', lot_number: lot.number, lot_name: lot.name)
  end

  def lot_legal_specialisms(lot)
    t('legal_panel_for_government.journey.lot_legal_specialisms', lot_number: lot.number)
  end
end

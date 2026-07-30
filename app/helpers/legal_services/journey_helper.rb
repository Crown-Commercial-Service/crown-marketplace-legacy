module LegalServices::JourneyHelper
  include LegalServices::RatesHelper

  def lot_full_name(lot)
    "Lot #{lot.number[0]} - #{lot.name}"
  end

  def lot_full_name_via_number(lot_number)
    lot = Lot.find("RM6374.#{lot_number}")
    "Lot #{lot.number} - #{lot.name}"
  end

  def lot_legal_services(lot_number)
    "Lot #{lot_number} legal services"
  end
end

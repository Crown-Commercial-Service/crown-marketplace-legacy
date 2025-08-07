module LegalServices::JourneyHelper
  def lot_full_name(lot)
    "Lot #{lot.number[0]} - #{lot.name}"
  end

  def lot_legal_services(lot_number)
    "Lot #{lot_number} legal services"
  end
end

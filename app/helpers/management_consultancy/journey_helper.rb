module ManagementConsultancy::JourneyHelper
  def lot_full_name(lot)
    "Lot #{lot.number} - #{lot.name}"
  end

  def framework_lot_and_description(framework_name, lot)
    "#{framework_name} lot #{lot.number} - #{lot.name}"
  end
end

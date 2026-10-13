module LegalServices::RM6374::Admin::SuppliersHelper
  include Admin::SuppliersHelper

  SECTOR_NAME_TO_ID = {
    health: 1,
    local_community: 2,
    government_policy: 3,
    education: 4,
    defence: 5,
    infrastructure: 6,
    culture: 7
  }.freeze

  def sector_name_to_id_map
    SECTOR_NAME_TO_ID
  end

  def sector_id_for(name)
    SECTOR_NAME_TO_ID[name.to_sym]
  end
end

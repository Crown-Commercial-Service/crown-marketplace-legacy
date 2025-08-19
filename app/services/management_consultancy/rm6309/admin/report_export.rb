class ManagementConsultancy::RM6309::Admin::ReportExport < ReportExport
  class << self
    def search_criteria_headers
      ['Lot', 'Services']
    end

    def search_criteria_row(search_criteria)
      lot = Lot.find(search_criteria['lot_id'])

      [
        "Lot #{lot.number} - #{lot.name}",
        Service.where(id: search_criteria['service_ids']).order(:name).pluck(:name).join(";\n")
      ]
    end
  end
end

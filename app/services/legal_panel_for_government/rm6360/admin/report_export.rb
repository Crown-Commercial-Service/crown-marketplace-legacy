class LegalPanelForGovernment::RM6360::Admin::ReportExport < ReportExport
  class << self
    def search_criteria_headers
      ['Lot', 'Services', 'Countries']
    end

    def search_criteria_row(search_criteria)
      lot = Lot.find(search_criteria['lot_id'])

      [
        "Lot #{lot.number} - #{lot.name}",
        Service.where(id: search_criteria['service_ids']).order(:name).pluck(:name).join(";\n"),
        countries(search_criteria)
      ]
    end

    private

    def countries(search_criteria)
      return unless search_criteria['lot_id'].starts_with?('RM6360.4')

      if search_criteria['not_core_jurisdiction'] == 'no'
        Jurisdiction.core
      else
        Jurisdiction.where(id: search_criteria['jurisdiction_ids'])
      end.order(:name).pluck(:name).join(";\n")
    end
  end
end

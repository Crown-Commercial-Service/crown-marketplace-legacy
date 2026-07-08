class LegalServices::RM6374::Admin::ReportExport < ReportExport
  class << self
    def search_criteria_headers
      # NOTE: If RM6374 no longer searches/filters by specific services, remove 'Services' from this array.
      ['Central government', 'Lot', 'Services', 'Jurisdiction']
    end

    def search_criteria_row(search)
      search_criteria = search.search_criteria

      # Updated framework ID to RM6374
      lot = Lot.find("RM6374.#{search_criteria['lot_number']}#{search_criteria['jurisdiction']}")

      [
        search_criteria['central_government'].capitalize,
        "Lot #{search_criteria['lot_number']} - #{lot.name}",
        # NOTE: If services are removed from the framework entirely, you can delete this line.
        Service.where(lot_id: lot.id, number: search_criteria['service_numbers'] || ['1']).order(:name).pluck(:name).join(";\n"),
        JURISDICTION_LETTER_TO_NAME[search_criteria['jurisdiction']]
      ]
    end

    JURISDICTION_LETTER_TO_NAME = {
      'a' => 'England and Wales',
      'b' => 'Scotland',
      'c' => 'Northern Ireland'
    }.freeze
  end
end
class LegalServices::RM6374::Admin::ReportExport < ReportExport
  class << self
    def search_criteria_headers
      ['Name', 'Job title', 'Email address', 'Organisation name', 'Organisation sector', 'Requirements start date', 'Requirements end date', 'Requirements estimated total value', 'Replaces existing contract', 'Award through GCA framework', 'Opted in to be contacted', 'Search sector', 'Lot', 'Services', 'Jurisdiction']
    end

    def search_criteria_row(search) # rubocop:disable Metrics/AbcSize,Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity
      search_criteria = search.search_criteria
      buyer_detail = search.user.buyer_detail

      lot = Lot.find("RM6374.#{search_criteria['lot_number']}")

      [
        buyer_detail.name,
        buyer_detail.job_title,
        buyer_detail.email,
        buyer_detail.organisation_name,
        buyer_detail.organisation_sector_name,
        "#{search_criteria['requirement_start_date_month']}/#{search_criteria['requirement_start_date_year']}",
        "#{search_criteria['requirement_end_date_month']}/#{search_criteria['requirement_end_date_year']}",
        "£#{search_criteria['requirement_estimated_total_value']}",
        if search_criteria['replaces_existing_contract'] == 'yes'
          'Yes'
        elsif search_criteria['replaces_existing_contract'] == 'no'
          'No'
        end,
        (I18n.t("legal_services.rm6374.journey.information_about_your_requirement.requirement_being_awarded.options.#{search_criteria['requirement_being_awarded']}") unless search_criteria['requirement_being_awarded'].nil?),
        search_criteria['ccs_can_contact_you'] == 'yes' ? 'Yes' : 'No',
        (I18n.t("legal_services.rm6374.journey.choose_sector.options.#{search_criteria['sector']}.label") unless search_criteria['sector'].nil?),
        "Lot #{search_criteria['lot_number']} - #{lot.name}",
        Service.where(lot_id: lot.id, number: search_criteria['service_numbers'] || ['1']).order(:name).pluck(:name).join(";\n"),
        search_criteria['lot_number'] == '6' ? 'All regions' : JURISDICTION_LETTER_TO_NAME[search_criteria['jurisdiction']]
      ]
    end

    def additional_details_headers
      ['Selected call off mechanism', 'Results downloaded', "Suppliers' prospectus reviewed", 'Suppliers selected for comparison']
    end

    def additional_details_row(search)
      search_additional_details = search.additional_details || {}

      [
        search_additional_details['call_off_mechanism'].to_s,
        search_additional_details['results_downloaded'] ? 'Yes' : 'No',
        case search_additional_details['results_reviewed']
        when true
          'Yes'
        when false
          'No'
        else
          ''
        end,
        (search_additional_details['comparison_result'] || []).map(&:first).sort.join(";\n")
      ]
    end

    JURISDICTION_LETTER_TO_NAME = {
      'a' => 'England and Wales',
      'b' => 'Scotland',
      'c' => 'Northern Ireland'
    }.freeze
  end
end

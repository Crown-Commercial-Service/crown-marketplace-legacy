class LegalPanelForGovernment::RM6360::Admin::ReportExport < ReportExport
  class << self
    def search_criteria_headers
      ['Name', 'Job title', 'Email address', 'Organisation name', 'Organisation sector', 'Requirements start date', 'Requirements end date', 'Requirements estimated total value', 'Opted in to be contacted', 'Lot', 'Services', 'Countries']
    end

    def search_criteria_row(search)
      search_criteria = search.search_criteria
      ccs_can_contact_you = search_criteria['ccs_can_contact_you'] == 'yes'
      buyer_detail = search.user.buyer_detail

      lot = Lot.find(search_criteria['lot_id'])

      [
        ccs_can_contact_you ? buyer_detail.name : '',
        buyer_detail.job_title,
        ccs_can_contact_you ? buyer_detail.email : '',
        buyer_detail.organisation_name,
        buyer_detail.organisation_sector_name,
        "#{search_criteria['requirement_start_date_month']}/#{search_criteria['requirement_start_date_year']}",
        "#{search_criteria['requirement_end_date_month']}/#{search_criteria['requirement_end_date_year']}",
        "£#{search_criteria['requirement_estimated_total_value']}",
        ccs_can_contact_you ? 'Yes' : 'No',
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

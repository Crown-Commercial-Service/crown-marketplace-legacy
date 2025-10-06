module Pages
  class SummaryRowRowSection < SitePrism::Section
    element :key, 'dt.govuk-summary-list__key'
    element :value, 'dd.govuk-summary-list__value'
  end

  class BuyerDetailPage < SitePrism::Page
    section :buyer_details, '#main-content' do
      section :'Personal details', '#buyer-details-summery--personal-details' do
        sections :rows, SummaryRowRowSection, 'govuk-summary-list__row'
      end
      section :'Organisation details', '#buyer-details-summery--organisation-details' do
        sections :rows, SummaryRowRowSection, 'govuk-summary-list__row'
      end
    end

    section :sector, '#organisation_sector-form-group' do
      element :'Defence and Security', '#buyer_detail_organisation_sector_defence_and_security'
      element :Health, '#buyer_detail_organisation_sector_health'
      element :'Government Policy', '#buyer_detail_organisation_sector_government_policy'
      element :'Local Community and Housing', '#buyer_detail_organisation_sector_local_community_and_housing'
      element :Infrastructure, '#buyer_detail_organisation_sector_infrastructure'
      element :Education, '#buyer_detail_organisation_sector_education'
      element :'Culture, Media and Sport', '#buyer_detail_organisation_sector_culture_media_and_sport'
    end

    section :contact_opt_in, '#contact_opt_in-form-group' do
      element :Yes, '#buyer_detail_contact_opt_in_true'
      element :No, '#buyer_detail_contact_opt_in_false'
    end
  end
end

module Pages
  class SupplyTeachers < SitePrism::Page
    element :date_field, '#main-content'
    element :'contract start', '#contract-start-date'
    element :hire, '#hire-date'
    element :'holiday 1 start', '#holiday-1-start-date'
    element :'holiday 1 end', '#holiday-1-end-date'
    element :'holiday 2 start', '#holiday-2-start-date'
    element :'holiday 2 end', '#holiday-2-end-date'
    element :notice, '#notice-date'

    section :agency_results, '#main-content' do
      element :number_of_agencies, 'div.govuk-grid-row > div > form > div > div.govuk-grid-column-two-thirds > p:nth-child(1) > strong:nth-child(1)'
      elements :suppliers, '.supplier-record'
      elements :choices, '.cmp-sidebar > ul > li'
    end

    section :managed_service_providers, '#main-content' do
      element :number_of_agencies, '> div.govuk-grid-row > div > p'
      elements :agencies, '.agency-record'
    end

    section :all_agencies, '#main-content' do
      element :number_of_agencies, '> div.govuk-grid-row > div > p'
      elements :agencies, '.agency-row'
    end

    section :agency_details, '#main-content' do
      element :sub_title, '.app-content__section-heading'
      section :branch_details, 'div.govuk-grid-row > div:nth-child(1) > div' do
        element :Branch, 'div:nth-child(1) > p:nth-child(1)'
        element :Region, 'div:nth-child(1) > p:nth-child(2)'
        element :'Contact name', 'div:nth-child(2) > p:nth-child(1)'
        element :'Contact email', 'div:nth-child(2) > p:nth-child(2)'
        element :'Phone number', 'div:nth-child(2) > p:nth-child(3)'
        element :Address, 'div:nth-child(3) > ul'
      end
      element :agency_rates_table, 'table > tbody'
    end

    section :panel, '.govuk-panel' do
      element :body, '.govuk-panel__body'
    end

    section :temp_to_perm_result, '#main-content' do
      element :information, '#temp-to-perm-result-information'
    end
  end
end

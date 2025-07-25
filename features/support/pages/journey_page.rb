module Pages
  class Journey < SitePrism::Page
    element :sub_title, :xpath, '//h1/../span'
    elements :service_selection, '#selection-checkboxes .govuk-checkboxes__item:not(.govuk-visually-hidden) label'

    section :basket, '#css-list-basket' do
      elements :selection, 'ul > li > span'
      element :selection_count, 'div > h2'
      element :remove_all, '#removeAll'
    end

    section :selection, '#selection-checkboxes' do
      elements :checkboxes, '.govuk-checkboxes__input'
    end

    element :number_of_companies, '#main-content > div.govuk-grid-row > div > p'
    element :number_of_suppliers, '#main-content > div.govuk-grid-row > div > div:nth-child(3) > div > p'

    elements :suppliers, '.ccs-results-list a'

    sections :legal_panel_for_government_suppliers, '.ccs-results-list h2' do
      element :name, '.ccs-results-list__supplier-name > a'
      element :prospectus, '.ccs-results-list__prospectus > a'
    end

    section :supplier_rates_table_headings, 'table thead > tr' do
      element :rate_type_1, 'th:nth-of-type(2)'
      element :rate_type_2, 'th:nth-of-type(3)'
    end

    section :supplier_rates_table, 'div:not(.govuk-tabs__panel--hidden) > table tbody' do
      sections :rows, 'tr' do
        element :position, 'th'
        element :rate, 'td:nth-of-type(1)'
        element :rate_advice, 'td:nth-of-type(1)'
        element :rate_delivery, 'td:nth-of-type(2)'
        element :hourly_rate, 'td:nth-of-type(1)'
        element :daily_rate, 'td:nth-of-type(2)'
        element :monthly_rate, 'td:nth-of-type(3)'
      end
    end

    elements :contact_details, '.ccs-contact-details dd'
    element :supplier_prospectus, '.ccs-supplier-prospectus'
  end
end

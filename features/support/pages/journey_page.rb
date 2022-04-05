module Pages
  class Journey < SitePrism::Page
    section :basket, '#css-list-basket' do
      elements :selection, 'ul > li > span'
      element :selection_count, 'div > h2'
      element :remove_all, '#removeAll'
    end

    section :selection, '#selection-checkboxes' do
      elements :checkboxes, '.govuk-checkboxes__input'
    end

    element :number_of_companies, '#main-content > div.govuk-grid-row > div > p'
    elements :suppliers, 'section a'

    element :supplier_rates_table, 'table tbody'
    elements :contact_details, '.ccs-contact-details dd'
  end
end

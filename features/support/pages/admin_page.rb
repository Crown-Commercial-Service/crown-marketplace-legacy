module Pages
  class SummaryList < SitePrism::Section
    element :key, '.govuk-summary-list__key'
    element :value, '.govuk-summary-list__value'
  end

  class TableRow < SitePrism::Section
    element :row_head, 'th'
    elements :row_items, 'td'
  end

  class Admin < SitePrism::Page
    element :supplier_search_input, '#table_filter'

    sections :suppliers, '#suppliers-table > tbody > tr', visible: true do
      element :supplier_name, 'th'
      element :'View details', 'td:nth-child(2) > a'
      element :'View lot data', 'td:nth-child(3) > a'
    end

    sections :'Supplier information', SummaryList, '#supplier-details--supplier-information > .govuk-summary-list__row'
    sections :'Contact information', SummaryList, '#supplier-details--contact-information > .govuk-summary-list__row'
    sections :'Additional information', SummaryList, '#supplier-details--additional-information > .govuk-summary-list__row'

    sections :supplier_lots, '.supplier-lot-data--lots' do
      element :lot_name, 'h2'
      sections :lot_info, SummaryList, '.govuk-summary-list > .govuk-summary-list__row'
    end

    sections :supplier_section_tables, '.govuk-table' do
      element :caption, '.govuk-table__caption'
      elements :headings, '.govuk-table__head > .govuk-table__row > th'
      sections :rows, TableRow, '.govuk-table__body > .govuk-table__row'
    end

    sections :supplier_rates_tables, '.ccs-rates-table' do
      element :caption, '.govuk-table__caption'
      elements :headings, '.govuk-table__head > .govuk-table__row > th'
      sections :rows, TableRow, '.govuk-table__body > .govuk-table__row'
    end

    sections :supplier_branches_tables, '#agency-branches' do
      elements :headings, '.govuk-table__head > .govuk-table__row > th'
      sections :rows, TableRow, '.govuk-table__body > .govuk-table__row'
    end
  end
end

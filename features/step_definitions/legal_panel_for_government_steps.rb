Given('I enter {string} for the requirement {string} date') do |date, field|
  add_requirement_dates(field, *date_options(date))
end

Then('I should see that {string} suppliers can provide legal specialisms for government') do |number_of_suppliers|
  expect(legal_panel_for_government_page.number_of_suppliers).to have_content "#{number_of_suppliers} suppliers can provide the legal specialisms that meet your requirements."
end

Then('the selected legal service for government suppliers are:') do |suppliers|
  supplier_element_rows = legal_panel_for_government_page.suppliers.sort_by { |row| row.name.text }
  supplier_names_and_prospectus = suppliers.raw

  expect(supplier_element_rows.length).to eq supplier_names_and_prospectus.length

  supplier_element_rows.zip(supplier_names_and_prospectus).each do |row, (expected_name, expected_prospectus)|
    expect(row.name).to have_content expected_name
    expect(row.prospectus).to have_content expected_prospectus
  end
end

Then('I should see that {string} suppliers have been selected for comparison') do |number_of_suppliers|
  expect(legal_panel_for_government_page.number_of_suppliers).to have_content "#{number_of_suppliers} suppliers have been selected for comparison."
end

Then('I click on {string} legal panel for governemnt supplier') do |supplier_name|
  legal_panel_for_government_page.first('a', text: supplier_name).click
end

def add_requirement_dates(section, month, year)
  legal_panel_for_government_page.send(section.to_sym).find('.govuk-date-input__item:nth-of-type(1) .govuk-date-input__input').set(month)
  legal_panel_for_government_page.send(section.to_sym).find('.govuk-date-input__item:nth-of-type(2) .govuk-date-input__input').set(year)
end

Then('the sub title is {string}') do |title|
  expect(journey_page.sub_title).to have_content(title)
end

Then('I should see the following options for the lot:') do |services|
  journey_page.service_selection.zip(services.raw.flatten) do |element, service|
    expect(element).to have_content(service)
  end
end

Then('the basket should say {string}') do |basket_text|
  expect(journey_page.basket.selection_count).to have_content(basket_text)
end

Then('the remove all link should not be visible') do
  expect(journey_page.basket.remove_all).not_to be_visible
end

Then('the remove all link should be visible') do
  expect(journey_page.basket.remove_all).to be_visible
end

Then('the following items should appear in the basket:') do |items|
  expect(journey_page.basket.selection.map(&:text)).to match_array(items.raw.flatten)
end

Then('I check the following items:') do |items|
  items.raw.flatten.each do |item|
    page.check(item)
  end
end

When('I remove the following items from the basket:') do |items|
  items.raw.flatten.each do |item|
    journey_page.basket.selection(text: item).first.find(:xpath, '../a').click
  end
end

Given('I select all the services') do
  journey_page.selection.checkboxes.map(&:check)
end

Then('I should see that {string} companies can provide consultants') do |number_of_companies|
  expect(journey_page.number_of_companies).to have_content "#{number_of_companies} companies can provide consultants that meet your requirements"
end

Then('I should see that {string} suppliers can provide legal services') do |number_of_suppliers|
  expect(journey_page.number_of_suppliers).to have_content "#{number_of_suppliers} suppliers can provide legal services that meet your requirements."
end

Then('the selected suppliers are:') do |suppliers|
  supplier_elements = journey_page.suppliers
  supplier_names = suppliers.raw.flatten

  expect(supplier_elements.length).to eq supplier_names.length

  supplier_elements.zip(supplier_names).each do |actual, expected|
    expect(actual).to have_content expected
  end
end

Then('the selected legal service suppliers are:') do |suppliers|
  supplier_element_names = journey_page.suppliers.map(&:text).sort
  supplier_names = suppliers.raw.flatten

  expect(supplier_element_names.length).to eq supplier_names.length

  supplier_element_names.zip(supplier_names).each do |actual, expected|
    expect(actual).to have_content expected
  end
end

Then('I deselect all the items') do
  journey_page.selection.checkboxes.map(&:uncheck)
end

Then('the supplier {string} an SME') do |option|
  case option
  when 'is'
    expect(journey_page.find('h1')).to have_content('SME')
  when 'is not'
    expect(journey_page.find('h1')).not_to have_content('SME')
  end
end

Then('the rate for the {string} is {string}') do |role, rate|
  expect(journey_page.supplier_rates_table.rows[MC_ROLES.index(role)].rate).to have_content(rate)
end

Then('the contact details for the supplier are:') do |contact_details|
  journey_page.contact_details.zip(contact_details.raw.flatten).each do |actual, expected|
    expect(actual).to have_content expected
  end
end

Then('the {string} lot 1 rates are {string}, {string} and {string}') do |role, hourly_rate, daily_rate, monthly_rate|
  table_row = journey_page.supplier_rates_table.rows[LS_LOT_1_ROLES.index(role)]

  expect(table_row.hourly_rate).to have_content(hourly_rate)
  expect(table_row.daily_rate).to have_content(daily_rate)
  expect(table_row.monthly_rate).to have_content(monthly_rate)
end

Then('the {string} rates are {string}, {string} and {string}') do |role, hourly_rate, daily_rate, monthly_rate|
  table_row = journey_page.supplier_rates_table.rows[LS_ROLES.index(role)]

  expect(table_row.hourly_rate).to have_content(hourly_rate)
  expect(table_row.daily_rate).to have_content(daily_rate)
  expect(table_row.monthly_rate).to have_content(monthly_rate)
end

MC_ROLES = ['Analyst / Junior Consultant', 'Consultant', 'Senior Consultant / Engagement Manager / Project Lead', 'Principal Consultant / Associate Director', 'Managing Consultant / Director', 'Partner'].freeze
LS_LOT_1_ROLES = ['Managing Practitioner', 'Senior Practitioner', 'Solicitor/Associate', 'Legal Support Practitioner/Executive'].freeze
LS_ROLES = ['Partner including Managing Partner', 'Senior Solicitor/Senior Associate/Legal Director', 'Solicitor/Associate', 'Junior Solicitor', 'Trainee/Paralegal'].freeze

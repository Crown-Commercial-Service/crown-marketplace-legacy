Then('I enter {string} for the supplier search') do |supplier_name|
  admin_page.supplier_search_input.fill_in with: "#{supplier_name}\n"
end

Then('I should see the following suppliers on the page:') do |supplier_names|
  expect(admin_page.suppliers.length).to eq(supplier_names.raw.flatten.length)

  admin_page.suppliers.map(&:supplier_name).zip(supplier_names.raw.flatten).each do |element, value|
    expect(element).to have_content(value)
  end
end

Then('I click on {string} for {string}') do |text, supplier_name|
  admin_page.suppliers.find { |element| element.supplier_name.text == supplier_name }.send(text).click
end

Then('I should see the following details in the {string} summary:') do |summary, supplier_data|
  summary_rows = admin_page.send(summary)

  expect(summary_rows.length).to eq(supplier_data.raw.length)

  summary_rows.zip(supplier_data.raw).each do |section, (expected_key, expected_value)|
    expect(section.key).to have_content(expected_key)
    expect(section.value).to have_content(expected_value)
  end
end

Then('I should see the following details in the summary for the lot {string}:') do |lot_name, supplier_data|
  summary_rows = admin_page.supplier_lots.find { |element| element.lot_name.text == lot_name }.lot_info

  expect(summary_rows.length).to eq(supplier_data.raw.length)

  summary_rows.zip(supplier_data.raw).each do |section, (expected_key, expected_value)|
    expect(section.key).to have_content(expected_key)
    expect(section.value).to have_content(expected_value)
  end
end

Then('I click on {string} for the lot {string}') do |view_link_text, lot_name|
  admin_page.supplier_lots.find { |element| element.lot_name.text == lot_name }.lot_info.find { |section| section.value.text.starts_with?(view_link_text) }.find('a').click
end

Then('the supplier should be assigned to the {string} as follows:') do |_section, section_items|
  admin_check_section_items(
    admin_page.supplier_section_summaries.first.section_items.first,
    section_items
  )
end

Then('the supplier should be assigned to the {string} in {string} as follows:') do |_section, category, section_items|
  admin_check_section_items(
    admin_page.supplier_section_summaries.first.section_items.find { |section| section.heading.text == category },
    section_items
  )
end

Then('the rates in the table are:') do |rates|
  admin_check_rates(
    admin_page.supplier_rates_tables.first,
    rates
  )
end

Then('the rates in the {string} table are:') do |country_name, rates|
  admin_check_rates(
    admin_page.supplier_rates_tables.find { |element| element.title.text == "Supplier rates for #{country_name}" },
    rates
  )
end

Then('the branches in the table are:') do |branches|
  admin_check_branches(
    admin_page.supplier_branches_summaries,
    branches
  )
end

Then('I should see rate tables for the following jurisdictions:') do |jurisdictions|
  expect(admin_page.supplier_rates_tables.length).to eq(jurisdictions.raw.flatten.length)

  admin_page.supplier_rates_tables.zip(jurisdictions.raw.flatten).each do |table, jurisdiction|
    expect(table.title).to have_content(jurisdiction)
  end
end

def admin_check_table_headings(table, items)
  table_headings = table.headings
  headings = items.raw[0]

  expect(table_headings.length).to eq(headings.length)

  table_headings.zip(headings).each do |element, expected_heading|
    expect(element).to have_content(expected_heading)
  end
end

def admin_check_table_rows(table, items)
  table_rows = table.rows
  rows = items.raw[1..]

  expect(table_rows.length).to eq(rows.length)

  table_rows.zip(rows).each do |row, expected_items|
    expect(row.row_head).to have_content(expected_items[0])

    row.row_items.zip(expected_items[1..]) do |row_item, expected_value|
      expect(row_item).to have_content(expected_value)
    end
  end
end

def admin_check_section_items(summary, section_items)
  items = summary.items
  expected_items = section_items.raw.flatten

  expect(items.length).to eq(expected_items.length)

  items.zip(expected_items).each do |item, expected_value|
    expect(item).to have_content(expected_value)
  end
end

def admin_check_rates(table, rates)
  admin_check_table_headings(table, rates)
  admin_check_table_rows(table, rates)
end

# rubocop:disable Metrics/AbcSize
def admin_check_branches(summaries, branch_items)
  branches = branch_items.raw[1..].map { |branch_row| branch_items.raw[0].zip(branch_row).to_h }

  expect(summaries.length).to eq(branches.length)

  summaries.zip(branches).each do |summary, branch|
    expect(summary.title).to have_content(branch['Branch'])
    expect(summary.rows.length).to eq(branch.length)

    summary.rows.zip(branch).each do |summary_row, (expected_key, expected_value)|
      expect(summary_row.key).to have_content(expected_key)
      expect(summary_row.value).to have_content(expected_value)
    end
  end
end
# rubocop:enable Metrics/AbcSize

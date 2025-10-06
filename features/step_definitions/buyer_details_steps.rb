Then('I check {string} for the sector') do |option|
  buyer_detail_page.sector.send(option.to_sym).choose
end

Then('the following buyer details have been entered for {string}:') do |section, buyer_details_table|
  row_sections = buyer_detail_page.buyer_details.send(section.to_sym).rows

  row_sections.zip(buyer_details_table.raw).each do |section, (field, value)|
    expect(section.key).to have_content(field)
    expect(section.value).to have_content(value)
  end
end

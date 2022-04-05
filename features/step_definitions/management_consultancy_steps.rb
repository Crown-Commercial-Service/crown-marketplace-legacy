Then('the sub title is {string}') do |title|
  expect(mc_page.sub_title).to have_content(title)
end

Then('I should see the following options for the lot:') do |services|
  mc_page.service_selection.zip(services.raw.flatten) do |element, service|
    expect(element).to have_content(service)
  end
end

Given 'I sign in and navigate to the start page for {string}' do |service|
  start_page_title = ''

  case service
  when 'legal services'
    create_buyer_user('ls')
    start_page_title = 'Do you work for central government?'
    visit legal_services_new_user_session_path
  when 'management consultancy'
    create_buyer_user('mc')
    start_page_title = 'Select the lot you need'
    visit management_consultancy_new_user_session_path
  when 'supply teachers'
    create_buyer_user('st')
    start_page_title = 'What is your school looking for?'
    visit supply_teachers_new_user_session_path
  end

  update_banner_cookie(true) if @javascript
  fill_in 'email', with: @user.email
  fill_in 'password', with: 'ValidPassword'
  click_on 'Sign in'
  step "I am on the '#{start_page_title}' page"
end

When('I go to the {string} start page') do |service|
  case service
  when 'legal services'
    visit legal_services_path
  when 'management consultancy'
    visit management_consultancy_path
  when 'supply teachers'
    visit supply_teachers_path
  end
end

Then('I am on the {string} page') do |title|
  expect(page.find('h1')).to have_content(title)
rescue NoMethodError
  expect(page.find('h1')).to have_content(title)
end

When('I click on {string}') do |button_text|
  click_on(button_text)
end

Then('I should sign in as an {string} buyer') do |service|
  create_buyer_user(service)
  step 'I sign in'
end

Then('I sign in') do
  fill_in 'email', with: @user.email
  fill_in 'password', with: 'ValidPassword'
  click_on 'Sign in'
end

Then('I should see the following error messages:') do |table|
  expect(page).to have_css('div.govuk-error-summary')
  expect(page.find('.govuk-error-summary__list').find_all('a').map(&:text).reject(&:empty?)).to eq table.raw.flatten
end

Given('I select {string}') do |item|
  choose item
end

Given('I check {string}') do |item|
  check item
end

When('I deselect the following items:') do |items|
  items.raw.flatten.each do |item|
    page.uncheck(item)
  end
end

Given('I click on the {string} back link') do |link_text|
  page.find('.govuk-back-link', text: link_text).click
end

Then('I click on the {string} button') do |button_text|
  page.find('.govuk-button', text: button_text).click
end

Then('the spreadsheet {string} is downloaded') do |spreadsheet_name|
  expect(page.response_headers['Content-Type']).to eq 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
  expect(page.response_headers['Content-Disposition']).to include "filename=\"#{spreadsheet_name}".gsub('(', '%28').gsub(')', '%29')
end

Then('I pause') do
  # binding.pry
  pending 'This step is used for debugging features'
end

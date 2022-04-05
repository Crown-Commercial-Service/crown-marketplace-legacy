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

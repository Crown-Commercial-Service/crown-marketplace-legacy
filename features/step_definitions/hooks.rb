# We need to do this because in Rails 7.2 the data is not preserved between the test server and the capybara server.
# This means we are using the truncation strategy so must reload the data between tests
Before('@javascript') do
  DatabaseCleaner.strategy = :truncation, { except: %w[spatial_ref_sys] }
end

Before('not @javascript') do
  DatabaseCleaner.strategy = :transaction
end

# Ensure DatabaseCleaner starts and cleans up properly
Before do
  DatabaseCleaner.start
end

Before do |scenario|
  %w[rm6238 rm6309 rm6187 rm6240].each do |framework|
    if scenario.location.file.include? framework
      @framework = framework.upcase
      break
    end
  end
end

Before('@javascript') do
  @javascript = true
end

Before('@allow_list') do
  stub_allow_list
end

After('@allow_list') do
  close_allow_list
end

Before('not @javascript') do
  page.driver.browser.set_cookie('cookie_preferences_cmp=%7B%22settings_viewed%22%3Atrue%2C%22usage%22%3Afalse%2C%22glassbox%22%3Afalse%7D')
end

Before('@geocode_london') do
  stub_geocoder('London')
end

Before('@geocode_liverpool') do
  stub_geocoder('Liverpool')
end

Before('@geocode_birmingham') do
  stub_geocoder('Birmingham')
end

After('@geocoder_london or @geocoder_liverpool or @geocode_birmingham') do
  reset_geocoder
end

Before('@mobile') do
  resize_window_to_mobile
end

After do
  DatabaseCleaner.clean
  if Framework.none?
    Rake::Task['db:static'].reenable
    Rake::Task['db:frameworks'].reenable
    Rake::Task['db:import_test_data'].reenable
    Rake::Task['db:import_test_data'].invoke
  end
end

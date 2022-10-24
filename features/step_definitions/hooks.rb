Before do |scenario|
  %w[rm6238 rm6187 rm6240].each do |framework|
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
  page.driver.browser.set_cookie('crown_marketplace_cookie_options_v1=%7B%22settings_viewed%22%3Atrue%2C%22google_analytics_enabled%22%3Afalse%2C%22glassbox_enabled%22%3Afalse%7D')
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

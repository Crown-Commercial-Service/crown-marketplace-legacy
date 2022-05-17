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
  page.driver.browser.set_cookie('crown_marketplace_cookie_settings_viewed=true')
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

Before('@RM3788') do
  open_rm3788_framework
end

Before('@RM3826') do
  open_rm3826_framework
end

After('@geocoder_london or @geocoder_liverpool or @geocode_birmingham') do
  reset_geocoder
end

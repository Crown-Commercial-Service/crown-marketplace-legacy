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

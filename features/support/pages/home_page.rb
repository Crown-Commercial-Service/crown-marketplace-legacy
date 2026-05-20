module Pages
  class Home < SitePrism::Page
    section :navigation, '#navigation' do
      elements :links, 'a'
      elements :buttons, 'button'
    end

    section :unrecognised_framework, '#main-content' do
      element :description, 'div.govuk-grid-row > div > p:nth-child(2)'
    end

    section :notification_banner, 'div.govuk-notification-banner' do
      element :heading, '.govuk-notification-banner__heading'
      element :message, '.govuk-notification-banner__content > p.govuk-body'
    end
  end
end

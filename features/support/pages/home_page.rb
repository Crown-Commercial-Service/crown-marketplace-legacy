module Pages
  class Home < SitePrism::Page
    elements :navigation_links, '#navigation a'

    section :unrecognised_framework, '#main-content' do
      element :description, 'div.govuk-grid-row > div > p:nth-child(2)'
    end
  end
end

module Pages
  class Home < SitePrism::Page
    section :navigation, '#navigation' do
      elements :links, 'a'
    end

    section :unrecognised_framework, '#main-content' do
      element :description, 'div.govuk-grid-row > div > p:nth-child(2)'
    end
  end
end

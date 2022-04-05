module Pages
  class MC < SitePrism::Page
    element :sub_title, :xpath, '//h1/../span'
    elements :service_selection, '#selection-checkboxes label'
  end
end

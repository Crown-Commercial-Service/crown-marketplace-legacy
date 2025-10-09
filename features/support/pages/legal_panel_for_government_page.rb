module Pages
  class LegalPanelForGovernment < SitePrism::Page
    element :start, '#requirement_start_date-form-group'
    element :end, '#requirement_end_date-form-group'
  end
end

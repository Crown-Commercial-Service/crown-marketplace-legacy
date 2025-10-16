module Pages
  class LegalPanelForGovernment < SitePrism::Page
    element :start, '#requirement_start_date-form-group'
    element :end, '#requirement_end_date-form-group'

    element :number_of_suppliers, '#main-content > div:nth-child(2) > div > p'

    sections :suppliers, '.ccs-results-list h2' do
      element :name, '.ccs-results-list__supplier-name'
      element :prospectus, '.ccs-results-list__prospectus > a'
    end

    section :have_you_reviewed, '.govuk-radios' do
      element :yes, '#have_you_reviewed_yes'
      element :no, '#have_you_reviewed_no'
    end
  end
end

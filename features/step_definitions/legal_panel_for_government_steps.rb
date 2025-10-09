Given('I enter {string} for the requirement {string} date') do |date, field|
  add_requirement_dates(field, *date_options(date))
end

def add_requirement_dates(section, month, year)
  legal_panel_for_government_page.send(section.to_sym).find('.govuk-date-input__item:nth-of-type(1) .govuk-date-input__input').set(month)
  legal_panel_for_government_page.send(section.to_sym).find('.govuk-date-input__item:nth-of-type(2) .govuk-date-input__input').set(year)
end

module SupplyTeachers::RM6238::SharedHelper
  def agency_rate_cell(rate)
    rate_value = if POSITION_ID_FOR_PERCENTAGE_RATES.include?(rate.position_id)
                   number_to_percentage(rate.rate_as_percentage, precision: 1)
                 else
                   format_money(rate.rate_in_pounds)
                 end

    {
      text: rate_value,
      classes: 'govuk-table__cell govuk-table__cell--numeric agency-record__markup-column'
    }
  end

  POSITION_ID_FOR_PERCENTAGE_RATES = [38, 40].freeze
end

module SupplyTeachers::RM6376::RatesHelper
  def rates_table_headers_and_rows(rates)
    [
      [
        {
          text: t('supply_teachers.rm6376.shared.rates_table.column1'),
          classes: 'govuk-!-width-three-quarters'
        },
        {
          text: t('supply_teachers.rm6376.shared.rates_table.column2'),
          classes: 'govuk-table__header--numeric govuk-!-width-one-quarter'
        }
      ],
      @lot.positions.order(:number).pluck(:id, :name).map do |position_id, position_name|
        [
          {
            text: t("supply_teachers.rm6376.shared.job_titles.#{position_name}")
          },
          {
            text: agency_rate(rates, position_id),
            classes: 'govuk-table__cell govuk-table__cell--numeric govuk-!-width-one-quarter'
          }
        ]
      end.compact,
    ]
  end

  def agency_rate(rates, position_id)
    if rates[position_id].rate_type == 'percentage'
      number_to_percentage(rates[position_id].normalized_rate, precision: 1)
    else
      format_money(rates[position_id].normalized_rate)
    end
  end
end

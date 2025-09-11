module ManagementConsultancy::RM6309::RatesHelper
  def rates_table_headers_and_rows(rates)
    [
      [
        {
          text: t('management_consultancy.rm6309.suppliers.show.position'),
          classes: 'govuk-!-width-one-half'
        }
      ] + @lot.positions.order(:number).pluck(:category).uniq.map do |category|
        {
          text: t('management_consultancy.rm6309.suppliers.show.max_day_rate', rate_type: t("management_consultancy.rm6309.suppliers.show.rate_type.#{category}")),
          classes: 'govuk-!-width-one-quarter'
        }
      end,
      @lot.positions_grouped_by_name.reverse.map do |position_name, positions|
        [
          {
            text: t("management_consultancy.rm6309.suppliers.show.job_titles.#{position_name}")
          },
          {
            text: number_to_currency(rates[positions[0].id].rate_in_pounds, precision: 0)
          },
          {
            text: number_to_currency(rates[positions[1].id].rate_in_pounds, precision: 0)
          }
        ]
      end,
    ]
  end
end

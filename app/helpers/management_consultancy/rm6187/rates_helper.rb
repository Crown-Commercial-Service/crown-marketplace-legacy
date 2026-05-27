module ManagementConsultancy::RM6187::RatesHelper
  def rates_table_headers_and_rows(rates)
    [
      [
        {
          text: t('management_consultancy.rm6187.suppliers.show.position'),
          classes: 'govuk-!-width-three-quarters'
        },
        {
          text: t('shared.rates_table.rm6187.categories.default'),
          classes: 'govuk-!-width-one-quarter'
        }
      ],
      @lot.positions.order(:number).pluck(:id, :name).map do |position_id, position_name|
        [
          {
            text: t("shared.rates_table.rm6187.job_titles.#{position_name}"),
          },
          {
            text: number_to_currency(rates[position_id].normalized_rate, precision: 0)
          }
        ]
      end,
    ]
  end
end

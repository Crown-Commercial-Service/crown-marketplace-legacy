module ManagementConsultancy::RM6187::RatesHelper
  def rates_table_headers_and_rows(rates)
    [
      [
        {
          text: t('management_consultancy.rm6187.suppliers.show.position'),
          classes: 'govuk-!-width-three-quarters'
        },
        {
          text: t('management_consultancy.rm6187.suppliers.show.max_day_rate'),
          classes: 'govuk-!-width-one-quarter'
        }
      ],
      [
        t('management_consultancy.rm6187.suppliers.show.job_titles.junior'),
        t('management_consultancy.rm6187.suppliers.show.job_titles.standard'),
        t('management_consultancy.rm6187.suppliers.show.job_titles.senior'),
        t('management_consultancy.rm6187.suppliers.show.job_titles.principal'),
        t('management_consultancy.rm6187.suppliers.show.job_titles.managing'),
        t('management_consultancy.rm6187.suppliers.show.job_titles.director'),
      ].map.with_index(8) do |job_text, position_id|
        [
          {
            text: job_text
          },
          {
            text: number_to_currency(rates[position_id].rate_in_pounds, precision: 0)
          }
        ]
      end,
    ]
  end
end

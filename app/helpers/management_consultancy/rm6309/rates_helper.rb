module ManagementConsultancy::RM6309::RatesHelper
  # rubocop:disable Metrics/AbcSize
  def rates_table_headers_and_rows(rates)
    [
      [
        {
          text: t('management_consultancy.rm6309.suppliers.show.position'),
          classes: 'govuk-!-width-one-half'
        }
      ] + rate_position_types[:names].map do |rate_position_type_name|
        {
          text: t('management_consultancy.rm6309.suppliers.show.max_day_rate', rate_type: t("management_consultancy.rm6309.suppliers.show.rate_type.#{rate_position_type_name}")),
          classes: 'govuk-!-width-one-quarter'
        }
      end,
      [
        t('management_consultancy.rm6309.suppliers.show.job_titles.director'),
        t('management_consultancy.rm6309.suppliers.show.job_titles.managing'),
        t('management_consultancy.rm6309.suppliers.show.job_titles.principal'),
        t('management_consultancy.rm6309.suppliers.show.job_titles.senior'),
        t('management_consultancy.rm6309.suppliers.show.job_titles.standard'),
        t('management_consultancy.rm6309.suppliers.show.job_titles.junior'),
      ].map.with_index do |job_text, index|
        [
          {
            text: job_text
          },
          {
            text: number_to_currency(rates[rate_position_types[:offset] - index].rate_in_pounds, precision: 0)
          },
          {
            text: number_to_currency(rates[rate_position_types[:offset] + 6 - index].rate_in_pounds, precision: 0)
          }
        ]
      end,
    ]
  end
  # rubocop:enable Metrics/AbcSize

  def rate_position_types
    @rate_position_types ||= if @lot.id == 'RM6309.10'
                               {
                                 names: ['Complex', 'Non-Complex'],
                                 offset: 31
                               }
                             else
                               {
                                 names: ['Advice', 'Delivery',],
                                 offset: 19
                               }
                             end
  end
end

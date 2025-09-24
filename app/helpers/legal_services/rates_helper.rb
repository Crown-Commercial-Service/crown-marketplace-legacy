module LegalServices::RatesHelper
  def rates_table_headers_and_rows(rates)
    [
      [
        {
          text: t('legal_services.rm6240.suppliers.rates_table.position'),
          classes: 'govuk-!-width-three-quarters'
        },
        {
          text: t('legal_services.rm6240.suppliers.rates_table.hourly'),
          classes: 'govuk-!-width-one-quarter'
        }
      ],
      @lot.positions.order(:number).pluck(:id, :name).map do |position_id, position_name|
        rate = display_rate(position_id, rates)

        next if rate.nil?

        [
          {
            text: t("legal_services.rm6240.suppliers.rates_table.job_titles.#{position_name}"),
          },
          {
            text: rate
          }
        ]
      end.compact,
    ]
  end

  def display_rate(position_id, rates)
    return if rates[position_id].nil? || rates[position_id].rate.zero?

    number_to_currency(rates[position_id].rate_in_pounds, precision: 2)
  end
end

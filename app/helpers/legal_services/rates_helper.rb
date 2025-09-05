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
      Position.where(id: legal_service_position_ids).order(:id).map do |position|
        rate = display_rate(position.id, rates)

        next if rate.nil?

        [
          {
            text: position.position
          },
          {
            text: rate
          }
        ]
      end.compact,
    ]
  end

  def legal_service_position_ids
    (1..7)
  end

  def display_rate(position_id, rates)
    return if rates[position_id].nil? || rates[position_id].rate.zero?

    number_to_currency(rates[position_id].rate_in_pounds, precision: 2)
  end
end

module LegalPanelForGovernment::RM6360::RatesHelper
  def rates_table_headers_and_rows(rates, jurisdiction_id)
    [
      [
        {
          text: t('legal_panel_for_government.rm6360.suppliers.rates_table.grade'),
          classes: 'govuk-!-width-three-quarters'
        },
        {
          text: t('legal_panel_for_government.rm6360.suppliers.rates_table.hourly'),
          classes: 'govuk-!-width-one-quarter'
        }
      ],
      positions.map do |position_id, position_name|
        rate = display_rate(position_id, jurisdiction_id, rates)

        next if rate.nil?

        [
          {
            text: t("legal_panel_for_government.rm6360.suppliers.rates_table.job_titles.#{position_name}"),
          },
          {
            text: rate
          }
        ]
      end.compact
    ]
  end

  def positions
    @positions ||= @lot.positions.order(:number).pluck(:id, :name)
  end

  def display_rate(position_id, jurisdiction_id, rates)
    return if rates[position_id].nil? || rates[position_id][jurisdiction_id].nil? || rates[position_id][jurisdiction_id].rate.zero?

    number_to_currency(rates[position_id][jurisdiction_id].rate_in_pounds, precision: 2)
  end
end

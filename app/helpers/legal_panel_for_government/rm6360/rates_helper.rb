module LegalPanelForGovernment::RM6360::RatesHelper
  def rates_table_headers_and_rows(rates, jurisdiction_id)
    [
      [
        {
          text: t('legal_panel_for_government.rm6360.suppliers.rates_table.position'),
          classes: 'govuk-!-width-three-quarters'
        },
        {
          text: t('legal_panel_for_government.rm6360.suppliers.rates_table.hourly'),
          classes: 'govuk-!-width-one-quarter'
        }
      ],
      positions.map do |position|
        rate = display_rate(position.id, jurisdiction_id, rates)

        next if rate.nil?

        [
          {
            text: position.position
          },
          {
            text: rate
          }
        ]
      end.compact
    ]
  end

  def legal_panel_for_government_ids
    @legal_panel_for_government_ids ||= if @lot.number.starts_with?('4')
                                          [56, 1, 51, 52, 53, 54, 55, 6, 57, 58, 59, 60]
                                        else
                                          [1, 51, 52, 53, 54, 55, 6]
                                        end
  end

  def positions
    @positions ||= Position.where(id: legal_panel_for_government_ids).sort_by { |position| legal_panel_for_government_ids.index(position.id) }
  end

  def display_rate(position_id, jurisdiction_id, rates)
    return if rates[position_id].nil? || rates[position_id][jurisdiction_id].nil? || rates[position_id][jurisdiction_id].rate.zero?

    number_to_currency(rates[position_id][jurisdiction_id].rate_in_pounds, precision: 2)
  end
end

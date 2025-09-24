module SupplyTeachers::RM6238::RatesHelper
  # rubocop:disable Metrics/AbcSize
  def rates_table_headers_and_rows(rates)
    [
      [
        {
          text: t('supply_teachers.rm6238.shared.rates_table.column1')
        },
        {
          text: capture do
            concat(t('supply_teachers.rm6238.shared.rates_table.column2'))
            concat(tag.br)
            concat(t('journey_step.supply_teachers.term_types.daily'))
          end,
          classes: 'govuk-table__header--numeric agency-record__markup-column'
        },
        {
          text: capture do
            concat(t('supply_teachers.rm6238.shared.rates_table.column2'))
            concat(tag.br)
            concat(t('journey_step.supply_teachers.term_types.six_weeks_plus'))
          end,
          classes: 'govuk-table__header--numeric agency-record__markup-column'
        }
      ],
      @lot.positions_grouped_by_name.map do |position_name, positions|
        next unless rates.key?(positions[0].id)

        [
          {
            text: t("journey_step.supply_teachers.job_titles.#{position_name}")
          },
          agency_rate_cell(rates, positions[0]),
          agency_rate_cell(rates, positions[-1]),
        ]
      end.compact,
    ]
  end
  # rubocop:enable Metrics/AbcSize

  def rates_table_headers_and_rows_lot_4(rates)
    [
      [
        {
          text: t('supply_teachers.rm6238.suppliers.education_technology_platform_vendor.column1')
        },
        {
          text: t('supply_teachers.rm6238.suppliers.education_technology_platform_vendor.column2'),
          classes: 'govuk-table__header--numeric agency-record__markup-column'
        }
      ],
      @lot.positions.order(:number).map do |position|
        [
          {
            text: t("journey_step.supply_teachers.job_titles.#{position.name}.#{position.category}")
          },
          agency_rate_cell(rates, position),
        ]
      end,
    ]
  end

  def agency_rate_cell(rates, position)
    {
      text: if position_is_percentage?(position)
              number_to_percentage(rates[position.id].rate_as_percentage, precision: 1)
            else
              format_money(rates[position.id].rate_in_pounds)
            end,
      classes: 'govuk-table__cell govuk-table__cell--numeric agency-record__markup-column'
    }
  end

  def position_is_percentage?(position)
    return true if position.id == 'RM6238.4.4'

    POSITION_NUMBER_FOR_PERCENTAGE_RATES.include?(position.number)
  end

  POSITION_NUMBER_FOR_PERCENTAGE_RATES = [9, 11].freeze
end

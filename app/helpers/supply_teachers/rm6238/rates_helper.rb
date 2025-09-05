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
      [
        [t('journey_step.supply_teachers.job_titles.teacher'), 41, 46],
        [t('journey_step.supply_teachers.job_titles.support'), 42, 47],
        [t('journey_step.supply_teachers.job_titles.senior'), 43, 48],
        [t('journey_step.supply_teachers.job_titles.other'), 44, 49],
        [t('journey_step.supply_teachers.job_titles.over_12_week'), 38, 38],
        [t('journey_step.supply_teachers.job_titles.nominated'), 39, 39],
        [t('journey_step.supply_teachers.job_titles.fixed_term'), 40, 40],
      ].map do |job_type, position_id_1, position_id_2|
        next unless rates.key?(position_id_1)

        [
          {
            text: job_type
          },
          agency_rate_cell(rates[position_id_1]),
          agency_rate_cell(rates[position_id_2]),
        ]
      end.compact
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
      [
        [t('journey_step.supply_teachers.job_titles.agency_management_daily'), 45],
        [t('journey_step.supply_teachers.job_titles.agency_management_six_weeks_plus'), 50],
        [t('journey_step.supply_teachers.job_titles.nominated'), 39],
        [t('journey_step.supply_teachers.job_titles.fixed_term'), 40],
      ].map do |job_type, position_id|
        [
          {
            text: job_type
          },
          agency_rate_cell(rates[position_id]),
        ]
      end
    ]
  end

  def agency_rate_cell(rate)
    rate_value = if POSITION_ID_FOR_PERCENTAGE_RATES.include?(rate.position_id)
                   number_to_percentage(rate.rate_as_percentage, precision: 1)
                 else
                   format_money(rate.rate_in_pounds)
                 end

    {
      text: rate_value,
      classes: 'govuk-table__cell govuk-table__cell--numeric agency-record__markup-column'
    }
  end

  POSITION_ID_FOR_PERCENTAGE_RATES = [38, 40].freeze
end

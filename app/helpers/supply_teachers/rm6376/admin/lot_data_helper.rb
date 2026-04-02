module SupplyTeachers::RM6376::Admin::LotDataHelper
  include Admin::LotDataHelper
  include SupplyTeachers::RM6376::RatesHelper

  def rates_form_table_headers_and_rows(rates)
    [
      [
        {
          text: t('supply_teachers.rm6376.shared.rates_table.column1'),
          classes: 'govuk-!-width-three-quarters'
        },
        {
          text: tag.span(t('supply_teachers.rm6376.shared.rates_table.column2'), id: aria_describedby_id),
          classes: 'govuk-!-width-one-quarter'
        }
      ],
      @lot.positions.order(:number).map do |position|
        input = create_rate_input(position, rates, ->(position) { I18n.t("supply_teachers.rm6376.shared.job_titles.#{position.name}") })

        [
          {
            text: label_for_table_header(input),
          },
          {
            text: input_for_table_cell(input)
          }
        ]
      end
    ]
  end
end

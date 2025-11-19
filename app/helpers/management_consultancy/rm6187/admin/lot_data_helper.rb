module ManagementConsultancy::RM6187::Admin::LotDataHelper
  include Admin::LotDataHelper
  include ManagementConsultancy::RM6187::RatesHelper

  def rates_form_table_headers_and_rows(rates)
    [
      [
        {
          text: t('management_consultancy.rm6187.suppliers.show.position'),
          classes: 'govuk-!-width-three-quarters'
        },
        {
          text: tag.span(t('management_consultancy.rm6187.suppliers.show.max_day_rate'), id: aria_describedby_id),
          classes: 'govuk-!-width-one-quarter'
        }
      ],
      @lot.positions.order(:number).map do |position|
        input = create_rate_input(position, rates, ->(position) { I18n.t("management_consultancy.rm6187.suppliers.show.job_titles.#{position.name}") })

        [
          {
            text: label_for_table_header(input),
          },
          {
            text: input_for_table_cell(input)
          }
        ]
      end,
    ]
  end
end

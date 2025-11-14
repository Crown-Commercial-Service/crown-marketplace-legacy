module LegalPanelForGovernment::RM6360::Admin::LotDataHelper
  include Admin::LotDataHelper
  include LegalPanelForGovernment::RM6360::RatesHelper

  def edit_page_heading
    @edit_page_heading ||= if @section == :rates
                             t('shared.admin.lot_data.edit.heading.heading_with_country', section: t(".heading.#{@section}"), country: @supplier_framework_lot_jurisdiction.jurisdiction.name)
                           else
                             super
                           end
  end

  def rates_form_table_headers_and_rows(rates)
    [
      [
        {
          text: t('legal_panel_for_government.rm6360.suppliers.rates_table.grade'),
          classes: 'govuk-!-width-three-quarters'
        },
        {
          text: tag.span(t('legal_panel_for_government.rm6360.suppliers.rates_table.hourly'), id: aria_describedby_id),
          classes: 'govuk-!-width-one-quarter'
        }
      ],
      @lot.positions.order(:number).map do |position|
        input = create_rate_input(position, rates, ->(position) { I18n.t("legal_panel_for_government.rm6360.suppliers.rates_table.job_titles.#{position.name}") })

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

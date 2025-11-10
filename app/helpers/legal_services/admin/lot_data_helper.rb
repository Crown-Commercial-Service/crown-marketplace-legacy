module LegalServices::Admin::LotDataHelper
  include Admin::LotDataHelper
  include LegalServices::RatesHelper

  def services_lot_title(supplier_lot_data_item)
    if supplier_lot_data_item[:lot][:number] == '3'
      super
    else
      t(
        'legal_services.admin.lot_data.index.supplier_lot_data_summary_list.lot_name',
        jurisdiction: t("legal_services.admin.lot_data.index.jurisdictions.#{supplier_lot_data_item[:lot][:number][1]}"),
        **supplier_lot_data_item[:lot]
      )
    end
  end

  def rates_form_table_headers_and_rows(rates)
    [
      [
        {
          text: t('legal_services.rm6240.suppliers.rates_table.position'),
          classes: 'govuk-!-width-three-quarters'
        },
        {
          text: tag.span(t('legal_services.rm6240.suppliers.rates_table.hourly'), id: aria_describedby_id),
          classes: 'govuk-!-width-one-quarter'
        }
      ],
      @lot.positions.order(:number).map do |position|
        input = create_rate_input(position, rates, ->(position) { I18n.t("legal_services.rm6240.suppliers.rates_table.job_titles.#{position.name}") })

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

  def display_rate(position_id, rates)
    return if rates[position_id].nil? || rates[position_id].rate.zero?

    number_to_currency(rates[position_id].normalized_rate, precision: 2)
  end
end

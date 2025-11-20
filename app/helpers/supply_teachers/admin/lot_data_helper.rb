module SupplyTeachers::Admin::LotDataHelper
  include Admin::LotDataHelper
  include SupplyTeachers::RM6238::RatesHelper

  def rates_form_table_headers_and_rows(rates)
    if @lot.number == '4'
      rates_form_table_headers_and_rows_lot_4(rates)
    else
      rates_form_table_headers_and_rows_not_lot_4(rates)
    end
  end

  # rubocop:disable Metrics/AbcSize
  def rates_form_table_headers_and_rows_not_lot_4(rates)
    [
      [
        {
          text: t('supply_teachers.rm6238.shared.rates_table.column1'),
          classes: 'govuk-!-width-one-half'
        },
        {
          text: tag.span(id: aria_describedby_id('daily')) do
            concat(t('supply_teachers.rm6238.shared.rates_table.column2'))
            concat(tag.br)
            concat(t('journey_step.supply_teachers.term_types.daily'))
          end,
          classes: 'govuk-!-width-one-quarter'
        },
        {
          text: tag.span(id: aria_describedby_id('six_weeks_plus')) do
            concat(t('supply_teachers.rm6238.shared.rates_table.column2'))
            concat(tag.br)
            concat(t('journey_step.supply_teachers.term_types.six_weeks_plus'))
          end,
          classes: 'govuk-!-width-one-quarter'
        }
      ],
      @lot.positions_grouped_by_name.map do |_position_name, positions|
        inputs = positions.map { |position| create_rate_input(position, rates, ->(position) { I18n.t("journey_step.supply_teachers.job_titles.#{position.name}") }, position.category || 'daily') }

        [
          {
            text: label_for_table_header_not_lot_4(inputs),
          },
        ] + inputs.map do |input|
          {
            text: input_for_table_cell(input),
            attributes: {
              colspan: inputs.length == 1 ? 2 : 1
            }
          }
        end
      end,
    ]
  end
  # rubocop:enable Metrics/AbcSize

  def rates_form_table_headers_and_rows_lot_4(rates)
    [
      [
        {
          text: t('supply_teachers.rm6238.suppliers.education_technology_platform_vendor.column1'),
          classes: 'govuk-!-width-three-quarters'
        },
        {
          text: tag.span(t('supply_teachers.rm6238.suppliers.education_technology_platform_vendor.column2'), id: aria_describedby_id),
          classes: 'govuk-!-width-one-quarter'
        }
      ],
      @lot.positions.order(:number).map do |position|
        input = create_rate_input(position, rates, ->(position) { I18n.t("journey_step.supply_teachers.job_titles.#{position.name}.#{position.category}") })

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

  def label_for_table_header_not_lot_4(inputs)
    error_messages = []

    inputs.each do |input|
      error_messages << CCS::Components::GovUK::ErrorMessage.new(context: self, message: input.send(:error_message), attribute: input.send(:attribute)) if input.send(:error_message)
    end

    tag.div(class: "govuk-form-group #{' govuk-form-group--error' if error_messages.any?}") do
      concat(inputs[0].send(:label).render)
      concat(tag.span(inputs[1].send(:label).render, class: 'govuk-visually-hidden')) if inputs[1]
      error_messages.each do |error_message|
        concat(error_message.render)
      end
    end
  end
end

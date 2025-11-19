module ManagementConsultancy::RM6309::Admin::LotDataHelper
  include Admin::LotDataHelper
  include ManagementConsultancy::RM6309::RatesHelper

  # rubocop:disable Metrics/AbcSize
  def rates_form_table_headers_and_rows(rates)
    [
      [
        {
          text: t('management_consultancy.rm6309.suppliers.show.position'),
          classes: 'govuk-!-width-one-half'
        }
      ] + @lot.positions.order(:number).pluck(:category).uniq.map do |category|
        {
          text: tag.span(t('management_consultancy.rm6309.suppliers.show.max_day_rate', rate_type: t("management_consultancy.rm6309.suppliers.show.rate_type.#{category}")), id: aria_describedby_id(category)),
          classes: 'govuk-!-width-one-quarter'
        }
      end,
      @lot.positions_grouped_by_name.reverse.map do |_position_name, positions|
        inputs = positions.map { |position| create_rate_input(position, rates, ->(position) { I18n.t("management_consultancy.rm6309.suppliers.show.job_titles.#{position.name}") }, position.category) }

        [
          {
            text: label_for_table_header(inputs),
          },
        ] + inputs.map do |input|
          {
            text: input_for_table_cell(input)
          }
        end
      end,
    ]
  end
  # rubocop:enable Metrics/AbcSize

  def label_for_table_header(inputs)
    error_messages = []

    inputs.each do |input|
      error_messages << CCS::Components::GovUK::ErrorMessage.new(context: self, message: input.send(:error_message), attribute: input.send(:attribute)) if input.send(:error_message)
    end

    tag.div(class: "govuk-form-group #{' govuk-form-group--error' if error_messages.any?}") do
      concat(inputs[0].send(:label).render)
      concat(tag.span(inputs[1].send(:label).render, class: 'govuk-visually-hidden'))
      error_messages.each do |error_message|
        concat(error_message.render)
      end
    end
  end
end

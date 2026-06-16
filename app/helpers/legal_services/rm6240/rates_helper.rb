module LegalServices::RM6240::RatesHelper
  include LegalServices::RatesHelper

  def rates_table_headers_and_rows(rates)
    [
      [
        {
          text: t('legal_services.rm6240.suppliers.rates_table.position'),
          classes: 'govuk-!-width-three-quarters'
        },
        {
          text: t('shared.rates_table.rm6240.categories.default'),
          classes: 'govuk-!-width-one-quarter'
        }
      ],
      @lot.positions.order(:number).pluck(:id, :name).map do |position_id, position_name|
        rate = display_rate(position_id, rates)

        next if rate.nil?

        [
          {
            text: t("shared.rates_table.rm6240.job_titles.#{position_name}"),
          },
          {
            text: rate
          }
        ]
      end.compact,
    ]
  end
end

module SupplyTeachers::RM6238::SharedHelper
  def grouped_rates_sorted_by_job_type(grouped_rates)
    job_types = SupplyTeachers::RM6238::JobType.all_codes

    grouped_rates.sort_by { |job_type, _| job_types.index(job_type) }
  end

  def agency_rate_cell(rate)
    rate_value = if rate.percentage?
                   number_to_percentage(rate.value, precision: 1)
                 else
                   format_money(rate.value)
                 end

    tag.td(rate_value, class: 'govuk-table__cell govuk-table__cell--numeric agency-record__markup-column')
  end

  def agency_sorted_rates(rates)
    rates.sort_by { |rate| AGENCY_SORT_ORDER.index(rate.term) }
  end

  AGENCY_SORT_ORDER = %w[daily six_weeks_plus].freeze
end

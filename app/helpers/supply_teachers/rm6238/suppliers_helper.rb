module SupplyTeachers::RM6238::SuppliersHelper
  def managed_service_provider_contact(supplier, lot_number)
    supplier.managed_service_providers.find_by(lot_number: lot_number)
  end

  def managed_service_provider_rate_cell(rate)
    rate_value = if rate.percentage?
                   number_to_percentage(rate.value, precision: 1)
                 else
                   format_money(rate.value)
                 end

    tag.td(rate_value, class: 'govuk-table__cell govuk-table__cell--numeric managed-service-provider-record__markup-column')
  end

  def managed_service_provider_sorted_rates(rates)
    rates.sort_by { |rate| MANAGED_SERVICE_PROVIDER_SORT_ORDER.index(rate.tenure_type) }
  end

  MANAGED_SERVICE_PROVIDER_SORT_ORDER = %w[daily six_weeks_plus].freeze
end

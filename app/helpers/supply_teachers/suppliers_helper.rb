module SupplyTeachers::SuppliersHelper
  def master_vendor_sorted_rates(rates)
    rates.sort_by { |rate| MASTER_VENDOR_SORT_ORDER.index(rate.term) }
  end

  MASTER_VENDOR_SORT_ORDER = %w[one_week twelve_weeks more_than_twelve_weeks].freeze
end

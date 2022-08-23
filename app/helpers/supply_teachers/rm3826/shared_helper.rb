module SupplyTeachers::RM3826::SharedHelper
  def agency_sorted_rates(rates)
    rates.sort_by { |rate| AGENCY_SORT_ORDER.index(rate.term) }
  end

  AGENCY_SORT_ORDER = %w[one_week twelve_weeks more_than_twelve_weeks].freeze
end

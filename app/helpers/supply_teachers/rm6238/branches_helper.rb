module SupplyTeachers::RM6238::BranchesHelper
  include SupplyTeachers::RM6238::RatesHelper

  def link_to_calculator?
    false
  end

  def daily_fee_or_markup(branch)
    number_to_currency(branch.rate.normalized_rate)
  end

  def finders_fee(rate)
    number_to_percentage(rate.normalized_rate, precision: 1)
  end
end

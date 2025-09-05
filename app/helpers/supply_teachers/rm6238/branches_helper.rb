module SupplyTeachers::RM6238::BranchesHelper
  include SupplyTeachers::RM6238::RatesHelper

  def link_to_calculator?
    false
  end

  def daily_fee_or_markup(branch)
    number_to_currency(branch.rate.rate_in_pounds)
  end

  def finders_fee(rate)
    number_to_percentage(rate.rate_as_percentage, precision: 1)
  end
end

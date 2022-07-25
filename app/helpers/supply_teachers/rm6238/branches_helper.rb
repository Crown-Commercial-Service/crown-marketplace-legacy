module SupplyTeachers::RM6238::BranchesHelper
  include SupplyTeachers::RM6238::SharedHelper

  def link_to_calculator?
    false
  end

  def daily_fee_or_markup(branch)
    number_to_currency(branch.rate)
  end

  def finders_fee(rate)
    number_to_percentage(rate, precision: 1)
  end
end

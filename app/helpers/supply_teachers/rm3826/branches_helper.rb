module SupplyTeachers::RM3826::BranchesHelper
  include SupplyTeachers::RM3826::SharedHelper

  def link_to_calculator?
    params[:payroll_provider] != 'school'
  end

  def daily_fee_or_markup(branch)
    number_to_percentage(branch.rate * 100, precision: 1)
  end

  def finders_fee(rate)
    number_to_percentage(rate * 100, precision: 1)
  end
end

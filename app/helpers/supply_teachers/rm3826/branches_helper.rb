module SupplyTeachers::RM3826::BranchesHelper
  def link_to_calculator?
    params[:payroll_provider] != 'school'
  end

  def fta_calculator_page?
    params[:worker_type] == 'agency_supplied' && params[:payroll_provider] == 'school'
  end

  def finders_fee(rate)
    number_to_percentage(rate * 100, precision: 1)
  end
end

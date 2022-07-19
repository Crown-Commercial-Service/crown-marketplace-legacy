module SupplyTeachers::RM6238::BranchesHelper
  def link_to_calculator?
    false
  end

  def fta_calculator_page?
    params[:worker_type] == 'agency_supplied' && params[:payroll_provider] == 'school'
  end

  def finders_fee(rate)
    number_to_percentage(rate, precision: 1)
  end
end

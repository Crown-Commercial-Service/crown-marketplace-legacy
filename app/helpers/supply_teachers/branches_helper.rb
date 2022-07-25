module SupplyTeachers::BranchesHelper
  def show_path(supplier_name_slug)
    "/supply-teachers/#{params[:framework]}/branches/#{supplier_name_slug}"
  end

  def fta_calculator_page?
    params[:worker_type] == 'agency_supplied' && params[:payroll_provider] == 'school'
  end
end

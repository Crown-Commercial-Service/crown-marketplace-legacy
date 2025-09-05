module SupplyTeachers::RM6238::SuppliersHelper
  include SupplyTeachers::RM6238::RatesHelper

  def show_path(supplier_framework)
    supply_teachers_rm6238_supplier_path(id: supplier_framework.id)
  end
end

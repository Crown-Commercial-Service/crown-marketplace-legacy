module SupplyTeachers::RM6376::SuppliersHelper
  include SupplyTeachers::RM6376::RatesHelper

  def show_path(supplier_framework)
    supply_teachers_rm6376_supplier_path(id: supplier_framework.id)
  end
end

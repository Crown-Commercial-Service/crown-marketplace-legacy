module SupplyTeachers::RM3826::SuppliersHelper
  include SupplyTeachers::RM3826::SharedHelper

  def show_path(supplier)
    supply_teachers_rm3826_supplier_path(id: supplier.supply_teachers_rm3826_supplier_id)
  end
end

module SupplyTeachers::RM6238::SuppliersHelper
  include SupplyTeachers::RM6238::SharedHelper

  def managed_service_provider_contact(supplier, lot_number)
    supplier.managed_service_providers.find_by(lot_number:)
  end

  def show_path(supplier)
    supply_teachers_rm6238_supplier_path(id: supplier.id)
  end
end

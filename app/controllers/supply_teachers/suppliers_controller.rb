module SupplyTeachers
  class SuppliersController < SupplyTeachers::FrameworkController
    before_action :set_suppliers, only: %i[all_suppliers search_all_suppliers]

    helper :telephone_number

    def all_suppliers
      @back_path = "/supply-teachers/#{params[:framework]}/looking-for?looking_for=all_suppliers"
      @suppliers_count = service_name::Branch.distinct_suppliers_count
    end

    def show
      @back_path = "/supply-teachers/#{params[:framework]}/all-suppliers"
      @supplier = service_name::Supplier.find(params[:id])
      @branches = service_name::Branch.where("supply_teachers_#{params[:framework]}_supplier_id = ?", params[:id]).order(:name)
    end

    def search_all_suppliers
      respond_to do |format|
        format.js
      end
    end

    private

    def service_name
      self.class.module_parent
    end

    def set_suppliers
      @paginated_suppliers = service_name::Branch.distinct_suppliers(agency_name_params)
    end

    def agency_name_params
      params.permit(:agency_name, :page)
    end
  end
end

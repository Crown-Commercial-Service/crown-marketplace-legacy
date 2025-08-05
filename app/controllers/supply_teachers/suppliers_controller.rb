module SupplyTeachers
  class SuppliersController < SupplyTeachers::FrameworkController
    before_action :set_lot_for_all_suppliers, only: %i[all_suppliers search_all_suppliers show]
    before_action :set_suppliers, only: %i[all_suppliers search_all_suppliers]

    helper :telephone_number

    def all_suppliers
      @back_path = "/supply-teachers/#{params[:framework]}/looking-for?looking_for=all_suppliers"
    end

    def show
      @back_path = "/supply-teachers/#{params[:framework]}/all-suppliers"
      @supplier_framework = Supplier::Framework.find(params[:id])
      @branches = @supplier_framework.lots.find_by(lot_id: @lot_id).branches.order(:name)
    end

    def search_all_suppliers
      render json: {
        html: render_to_string(
          partial: 'supply_teachers/suppliers/agencies_table',
          locals: { supplier_frameworks: @supplier_frameworks },
          formats: [:html]
        )
      }
    end

    private

    def service_name
      self.class.module_parent
    end

    def set_suppliers
      @supplier_frameworks = Kaminari.paginate_array(
        Supplier::Framework.with_lots(@lot_id)
                           .where(['lower(name) LIKE ?', "%#{agency_name&.downcase}%"])
                           .sort_by(&:supplier_name)
      ).page(params[:page])
    end

    def agency_name
      params.permit(:agency_name)[:agency_name]
    end
  end
end

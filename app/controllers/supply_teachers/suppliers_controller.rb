module SupplyTeachers
  class SuppliersController < SupplyTeachers::FrameworkController
    before_action :set_lot_for_all_suppliers, only: %i[all_suppliers search_all_suppliers show]
    before_action :set_supplier_filter, only: %i[all_suppliers search_all_suppliers]
    before_action :set_lot, only: :show

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
          locals: { supplier_frameworks_total: @supplier_frameworks_total, supplier_frameworks: @supplier_frameworks },
          formats: [:html]
        ),
        error_message_html: @supplier_filter.errors[:agency_postcode].any? ? helpers.govuk_error_message(@supplier_filter.errors[:agency_postcode].first, :agency_postcode) : nil
      }
    end

    private

    def service_name
      self.class.module_parent
    end

    def set_supplier_filter
      @supplier_filter = SupplierFilter.new(lot_id: @lot_id, agency_name: supplier_filter_params[:agency_name], agency_postcode: supplier_filter_params[:agency_postcode])

      filter_suppliers_result = @supplier_filter.filter_suppliers_query.sort_by(&:supplier_name)

      @supplier_frameworks_total = filter_suppliers_result.size
      @supplier_frameworks = Kaminari.paginate_array(filter_suppliers_result).page(params[:page])
    end

    def supplier_filter_params
      @supplier_filter_params ||= params.permit(:agency_name, :agency_postcode)
    end
  end
end

module Admin::SuppliersController
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user!, :authorize_user

    helper_method :service, :supplier_index_path, :supplier_show_path, :supplier_lot_data_index_path
  end

  def index
    @supplier_frameworks = Supplier::Framework.includes(:supplier).where(framework: params[:framework]).order('supplier.name')
  end

  def show
    @supplier_framework = Supplier::Framework.includes(:supplier, :contact_detail).find(params[:id])
  end

  private

  def supplier_index_path
    "#{service_path_base}/suppliers"
  end

  def supplier_show_path(supplier_framework_id)
    "#{service_path_base}/suppliers/#{supplier_framework_id}"
  end

  def supplier_lot_data_index_path(supplier_framework_id)
    "#{service_path_base}/suppliers/#{supplier_framework_id}/lot-data"
  end

  def authorize_user
    authorize! :manage, service.module_parent::Admin
  end

  def service
    @service ||= self.class.module_parent.module_parent
  end
end

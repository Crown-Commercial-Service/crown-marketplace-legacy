module Admin::LotDataController
  extend ActiveSupport::Concern

  include Admin::SupplierPathsConcern

  included do
    before_action :authenticate_user!, :authorize_user
    before_action :set_framework
    before_action :set_supplier_framework_lots, only: :index
    before_action :set_lot, :set_section_data, :set_supplier_framework_data, only: :show

    helper_method :service, :supplier_lot_data_index_path, :supplier_lot_data_item_show_path
  end

  def index
    @supplier_lot_data = @framework.lots.order(self.class::LOT_SORT_CRITERIA).map do |lot|
      {
        lot: {
          number: lot.number,
          name: lot.name
        },
        enabled: @supplier_framework_lots.key?(lot.id) && @supplier_framework_lots[lot.id].enabled,
        sections: lot_sections(lot)
      }
    end
  end

  def show; end

  private

  def set_framework
    @framework = Framework.find(params[:framework])
    @supplier_framework = Supplier::Framework.includes(:supplier).find(params[:supplier_id])
  end

  def set_lot
    @lot = @framework.lots.find_by(number: params[:lot_datum_id].gsub('-', '.'))
    @supplier_framework_lot = @supplier_framework.lots.find_by(lot_id: @lot.id)
  end

  def set_section_data
    case params[:section]
    when 'services'
      @services = @lot.services_grouped_by_category
    end
  end

  def set_supplier_framework
    @supplier_framework = Supplier::Framework.includes(:supplier).find(params[:supplier_id])
  end

  def set_supplier_framework_lots
    @supplier_framework_lots = @supplier_framework.lots.index_by(&:lot_id)
  end

  def set_supplier_framework_data
    case params[:section]
    when 'services'
      @supplier_framework_lot_services = @supplier_framework_lot.services.pluck(:service_id)
    when 'rates'
      @supplier_framework_lot_rates = @supplier_framework.grouped_rates_for_lot(@lot.id)
    when 'jurisdictions'
      @supplier_framework_lot_jurisdictions = @supplier_framework_lot.jurisdictions.pluck(:jurisdiction_id)
    when 'branches'
      @supplier_framework_lot_branches = @supplier_framework_lot.branches.order(:name)
    end
  end

  def supplier_lot_data_index_path
    "#{service_path_base}/suppliers/#{params[:supplier_id]}/lot-data"
  end

  def supplier_lot_data_item_show_path(lot_number, item)
    "#{service_path_base}/suppliers/#{params[:supplier_id]}/lot-data/#{lot_number.gsub('.', '-')}/#{item}"
  end

  def authorize_user
    authorize! :manage, service.module_parent::Admin
  end

  def service
    @service ||= self.class.module_parent.module_parent
  end
end

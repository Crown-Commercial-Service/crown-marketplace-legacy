module Admin::LotDataController
  extend ActiveSupport::Concern

  include Admin::SupplierPathsConcern

  included do
    before_action :authenticate_user!, :authorize_user
    before_action :set_framework, :set_supplier_framework
    before_action :set_supplier_framework_lots, :set_supplier_lot_data, only: :index
    before_action :set_lot, :set_supplier_framework_lot, :set_section, :set_section_data, :set_supplier_framework_lot_data, only: :show

    helper_method :service
  end

  def index
    render template: 'shared/admin/lot_data/index'
  end

  def show
    render template: 'shared/admin/lot_data/show'
  end

  def edit
    render template: 'shared/admin/lot_data/edit'
  end

  def update
    if update_for_section
      redirect_to action: :index
    else
      render template: 'shared/admin/lot_data/edit'
    end
  end

  private

  def set_framework
    @framework = Framework.find(params[:framework])
  end

  # rubocop:disable Rails/DynamicFindBy
  def set_lot
    @lot = @framework.lots.find_by_number_as_slug(params[:lot_number])
  end
  # rubocop:enable Rails/DynamicFindBy

  def set_supplier_framework
    @supplier_framework = Supplier::Framework.includes(:supplier).find(params[:supplier_id])
  end

  def set_supplier_framework_lots
    @supplier_framework_lots = @supplier_framework.lots.index_by(&:lot_id)
  end

  def set_supplier_framework_lot
    @supplier_framework_lot = @supplier_framework.lots.find_by(lot_id: @lot.id)
  end

  def set_supplier_lot_data
    @supplier_lot_data = @framework.lots.order(self.class::LOT_SORT_CRITERIA).map do |lot|
      {
        lot: {
          number: lot.number,
          number_as_slug: lot.number_as_slug,
          name: lot.name
        },
        enabled: @supplier_framework_lots.key?(lot.id) ? @supplier_framework_lots[lot.id].enabled : nil,
        sections: lot_sections(lot)
      }
    end
  end

  def set_supplier_framework_lot_data
    case @section
    when :services
      @supplier_framework_lot_service_ids = @supplier_framework_lot.services.pluck(:service_id)
    when :jurisdictions
      @supplier_framework_lot_jurisdiction_ids = @supplier_framework_lot.jurisdictions.pluck(:jurisdiction_id)
    when :rates
      @supplier_framework_lot_rates = @supplier_framework.grouped_rates_for_lot(@lot.id)
    when :branches
      @supplier_framework_lot_branches = @supplier_framework_lot.branches.order(:name)
    end
  end

  def set_section
    @section = params[:section].to_sym

    redirect_to action: :index unless self.class::SECTIONS_TO_SHOW.include?(@section)
  end

  def set_section_data
    case @section
    when :services
      @services = @lot.services_grouped_by_category
    end
  end

  def authorize_user
    authorize! :manage, service.module_parent::Admin
  end

  def service
    @service ||= self.class.module_parent.module_parent
  end
end

# rubocop:disable Metrics/ModuleLength
module Admin::LotDataController
  extend ActiveSupport::Concern

  include Admin::SupplierPathsConcern

  included do
    before_action :authenticate_user!, :authorize_user
    before_action :set_framework, :set_supplier_framework
    before_action :set_supplier_framework_lots, :set_supplier_lot_data, only: :index
    before_action :set_lot, :set_supplier_framework_lot, only: %i[show edit update]
    before_action :set_section_for_show, only: :show
    before_action :set_section_for_edit, :set_model, :set_supplier_framework_lot_jurisdiction, only: %i[edit update]
    before_action :set_section_data, :set_supplier_framework_lot_data, only: %i[show edit update]

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
    if send(:"update_for_#{@section}")
      if @section == :lot_status
        redirect_to action: :index
      else
        redirect_to action: :show, section: @section
      end
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
      @supplier_framework_lot_rates = if action_name.to_sym == :show
                                        @supplier_framework.grouped_rates_for_lot(@lot.id)
                                      else
                                        supplier_framework_lot_rates = @supplier_framework.grouped_rates_for_lot_and_jurisdictions(@lot.id, [@supplier_framework_lot_jurisdiction.jurisdiction_id])
                                        @lot.positions.pluck(:id).index_with { |position_id| supplier_framework_lot_rates[position_id][@supplier_framework_lot_jurisdiction.jurisdiction_id] || @supplier_framework_lot.rates.build(position_id: position_id, supplier_framework_lot_jurisdiction_id: @supplier_framework_lot_jurisdiction.id) }
                                      end
    when :branches
      @supplier_framework_lot_branches = @supplier_framework_lot.branches.order(:name)
    end
  end

  def set_section_for_show
    @section = params[:section].to_sym

    redirect_to action: :index unless self.class::SECTIONS_TO_SHOW.include?(@section)
  end

  def set_section_for_edit
    @section = params[:section].to_sym

    redirect_to action: :show, section: @section unless self.class::SECTIONS_TO_EDIT.include?(@section)
  end

  def set_section_data
    case @section
    when :services
      @services = @lot.services_grouped_by_category
    end
  end

  def set_model
    @model = case @section
             when :lot_status, :services, :rates
               @supplier_framework_lot
             end
  end

  def set_supplier_framework_lot_jurisdiction
    @supplier_framework_lot_jurisdiction = @supplier_framework_lot.jurisdictions.find_by(jurisdiction_id: params.fetch(:jurisdiction_id, 'GB')) if @section == :rates
  end

  def update_for_lot_status
    new_attributes = params[@model.model_name.param_key].present? ? params.expect("#{@model.model_name.param_key}": %i[enabled]) : {}

    @model.assign_attributes(new_attributes)

    @model.save(context: @section)
  end

  # rubocop:disable Metrics/AbcSize, Naming/PredicateMethod
  def update_for_services
    service_ids = (params[@model.model_name.param_key].present? ? params.expect("#{@model.model_name.param_key}": { service_ids: [] }) : {})[:service_ids] || []

    service_ids_to_add = service_ids - @supplier_framework_lot_service_ids
    service_ids_to_remove = @supplier_framework_lot_service_ids - service_ids

    ActiveRecord::Base.transaction do
      @model.services.where(service_id: service_ids_to_remove).find_each(&:destroy!)
      @model.services.build(service_ids_to_add.map { |service_id| { service_id: } }).each(&:save!)
    rescue ActiveRecord::RecordInvalid => e
      Rails.logger.error e
      Rollbar.log('error', e)
      @model.errors.add(:base, :service_update_invalid)
    end

    @model.errors.none?
  end
  # rubocop:enable Metrics/AbcSize, Naming/PredicateMethod

  def update_for_rates
    # rates = (params[@model.model_name.param_key].present? ? params.expect("#{@model.model_name.param_key}": { rates: @lot.positions.pluck(:id).map(&:to_sym) }) : {})[:rates] || {}
    # byebug
  end

  def authorize_user
    authorize! :manage, service.module_parent::Admin
  end

  def service
    @service ||= self.class.module_parent.module_parent
  end
end
# rubocop:enable Metrics/ModuleLength

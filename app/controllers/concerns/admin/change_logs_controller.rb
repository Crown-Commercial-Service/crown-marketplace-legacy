module Admin::ChangeLogsController
  extend ActiveSupport::Concern

  include Admin::SupplierPathsConcern

  included do
    before_action :authenticate_user!, :authorize_user
    before_action :set_change_logs, only: %i[index]
    before_action :set_change_log, only: %i[show]

    helper_method :service
  end

  def index
    render template: 'shared/admin/change_logs/index'
  end

  def show
    render template: 'shared/admin/change_logs/show'
  end

  private

  def authorize_user
    authorize! :manage, service.module_parent::Admin
  end

  def set_change_logs
    @change_logs = ChangeLog.where(framework_id: params[:framework]).includes(:user).order(created_at: :desc).page(params[:page])
  end

  def set_change_log
    @change_log = ChangeLog.where(framework_id: params[:framework]).find(params[:id])
  end

  def service
    @service ||= self.class.module_parent.module_parent
  end
end

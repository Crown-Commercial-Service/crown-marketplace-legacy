module Admin::DashboardController
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user!, :authorize_user, only: %i[index]

    helper_method :uploads_index_path, :suppliers_index_path, :reports_index_path, :framework_has_analytics?
  end

  def index; end

  private

  def authorize_user
    authorize! :manage, service.module_parent::Admin
  end

  def service
    @service ||= self.class.module_parent.module_parent
  end

  def uploads_index_path
    "#{service_path_base}/uploads"
  end

  def suppliers_index_path
    "#{service_path_base}/suppliers"
  end

  def reports_index_path
    "#{service_path_base}/reports"
  end

  def framework_has_analytics?
    true
  end
end

class ApplicationController < ActionController::Base
  class UnrecognisedFrameworkError < StandardError; end
  class UnrecognisedLiveFrameworkError < StandardError; end
  auto_session_timeout Devise.timeout_in

  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  before_action :authenticate_user!, :validate_service

  rescue_from CanCan::AccessDenied do
    redirect_to not_permitted_path
  end

  if Rails.env.production?
    rescue_from ActionController::UnknownFormat, ActionView::MissingTemplate do
      raise ActionController::RoutingError, 'Not Found'
    end
  end

  def gateway_url
    determine_gateway_url
  end

  def handle_unverified_request
    sign_out
  end

  private

  def determine_gateway_url
    if controller_path.split('/').first == 'supply_teachers'
      st_gateway_path
    else
      "#{service_path_base}/sign-in"
    end
  end

  delegate :ccs_homepage_url, to: Marketplace
  helper_method :ccs_homepage_url

  def service_path_base
    @service_path_base ||= begin
      service_path_base = ['']

      service = params[:service] || 'supply_teachers'
      service_name = service.split('/').first

      service_path_base << service_name.gsub('_', '-')
      service_path_base << (params[:framework] || Framework.send(service_name).current_framework)
      service_path_base << 'admin' if service.include?('admin')

      service_path_base.join('/')
    end
  end

  helper_method :service_path_base

  protected

  def configure_permitted_parameters
    attributes = %i[first_name last_name email phone_number mobile_number]
    devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
    devise_parameter_sanitizer.permit(:account_update, keys: attributes)
  end

  def authenticate_user!
    if user_signed_in?
      super
    else
      redirect_to gateway_url
    end
  end

  def set_end_of_journey
    @end_of_journey = true
  end

  def st_gateway_path
    if request.path&.include?('admin')
      "#{service_path_base}/sign-in"
    else
      "#{service_path_base}/gateway"
    end
  end

  def not_permitted_path
    "#{service_path_base}/not-permitted"
  end

  def validate_service
    redirect_to errors_404_path unless VALID_SERVICE_NAMES.include? params[:service]
  end

  VALID_SERVICE_NAMES = %w[supply_teachers supply_teachers/admin auth management_consultancy management_consultancy/admin legal_services legal_services/admin].freeze
end

module SharedPagesConcern
  extend ActiveSupport::Concern

  include CookieSettingsConcern

  included do
    skip_before_action :authenticate_user!, :authorize_user
  end

  def not_permitted
    render 'home/not_permitted', layout: 'error'
  end

  def accessibility_statement
    service = params[:service] || 'supply_teachers'
    service_name = service.split('/').first

    render "home/accessibility/#{service_name}/accessibility_statement"
  end

  def cookie_policy
    render 'home/cookie_policy'
  end

  def cookie_settings
    render 'home/cookie_settings'
  end
end

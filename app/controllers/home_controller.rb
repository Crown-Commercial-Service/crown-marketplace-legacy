class HomeController < ApplicationController
  before_action :authenticate_user!, :validate_service, except: %i[status index not_permitted]

  def index
    redirect_to ccs_homepage_url
  end

  def status
    render layout: false
  end

  def not_permitted
    params[:service] = 'supply_teachers' if params[:service] == 'auth' || params[:service].nil?
    render layout: 'error'
  end
end

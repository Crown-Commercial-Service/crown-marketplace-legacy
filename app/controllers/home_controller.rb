class HomeController < ApplicationController
  before_action :authenticate_user!, except: %i[status index not_permitted]

  def index
    redirect_to ccs_homepage_url

    params[:service] = 'management_consultancy' if params[:service].nil?
  end

  def status
    render layout: false
  end

  def not_permitted
    @service = params[:service]
  end
end

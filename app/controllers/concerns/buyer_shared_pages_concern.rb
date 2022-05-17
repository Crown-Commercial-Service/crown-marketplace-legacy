module BuyerSharedPagesConcern
  extend ActiveSupport::Concern

  included do
    skip_before_action :authenticate_user!, :authorize_user, except: :index
  end

  def index; end
end

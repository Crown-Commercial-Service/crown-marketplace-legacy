module BuyerDetailsConcern
  extend ActiveSupport::Concern

  included do
    before_action :set_buyer_detail, except: %i[index]
    before_action :redirect_to_buyer_detail, except: %i[show edit update]
    before_action :set_section, only: %i[edit update]
  end

  def index; end

  def show
    render template: 'buyer_details/show'
  end

  def edit
    render template: 'buyer_details/edit'
  end

  def update
    @buyer_detail.assign_attributes(buyer_detail_params)

    if @buyer_detail.save(context: @section)
      redirect_to action: :show
    else
      render template: 'buyer_details/edit'
    end
  end

  private

  def buyer_detail_params
    params[:buyer_detail].present? ? params.expect(buyer_detail: SECTION_TO_PARAMS[@section]) : {}
  end

  def set_buyer_detail
    @buyer_detail = BuyerDetail.find_or_create_by(user: current_user)
  end

  def set_section
    @section = params[:section].to_sym

    redirect_to action: :show unless SECTION_TO_PARAMS.include?(@section)
  end

  SECTION_TO_PARAMS = {
    personal_details: %i[name job_title],
    organisation_details: %i[organisation_name organisation_sector],
  }.freeze
end

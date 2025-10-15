module JourneyControllerActions
  extend ActiveSupport::Concern

  included do
    helper :journey

    before_action :build_journey
  end

  def start
    redirect_to @journey.first_step_path
  end

  def question
    render_form
  end

  def answer
    if @journey.valid?
      redirect_to @journey.next_step_path
    else
      render_form
    end
  end

  private

  def render_form
    @form_path = @journey.form_path
    @back_path = @journey.previous_step_path
    render @journey.template
  end

  def build_journey
    @journey = journey_class.new(params[:framework], params[:slug], params)
  end
end

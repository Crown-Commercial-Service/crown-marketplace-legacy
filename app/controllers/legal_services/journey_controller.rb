module LegalServices
  class JourneyController < LegalServices::FrameworkController
    include JourneyControllerActions

    def journey_class
      Journey
    end

    def answer
      is_rm6374 = params[:framework].to_s.casecmp('rm6374').zero?

      if is_rm6374 && params[:slug] == 'review-prospectus' && params[:review_prospectus] == 'no'
        @journey = LegalServices::Journey.new(params[:framework], params[:slug], params)
        if @journey.valid?
          clean_params = params.except(:slug, :action, :controller, :review_prospectus).permit!.to_h
          redirect_to legal_services_rm6374_suppliers_path(clean_params)
        else
          render :question
        end
      else
        super
      end
    end
  end
end
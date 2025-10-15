module LegalPanelForGovernment
  module RM6360
    class JourneyController < LegalPanelForGovernment::FrameworkController
      include JourneyControllerActions

      before_action :build_journey
      before_action :log_new_search, only: :question

      def question
        super
      end

      private

      def log_new_search
        Search.log_new_search(@journey.current_step.lot.framework, current_user, session.id, @journey.params.to_hash, @journey.current_step.suppliers_selector.supplier_frameworks)
      rescue StandardError => e
        Rollbar.log('error', e)
      end

      def build_journey
        @journey = LegalPanelForGovernment::Journey.new(params[:framework], 'supplier-results', params)
      end
    end
  end
end

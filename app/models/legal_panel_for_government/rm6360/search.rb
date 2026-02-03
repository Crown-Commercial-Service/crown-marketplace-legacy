module LegalPanelForGovernment
  module RM6360
    class Search < ::Search
      store_accessor :additional_details, %i[results_downloaded results_reviewed comparison_result]

      def self.log_results_downloaded_to_search(framework, user, session_id, params)
        search = find_search(framework, user, session_id, params)

        return unless search && search.results_downloaded.nil?

        search.update!(results_downloaded: true)
      end

      def self.log_supplier_rates_comparison(framework, user, session_id, params, comparison_result)
        search = find_search(framework, user, session_id, params)

        return unless search

        search.update!(results_reviewed: params[:have_you_reviewed] == 'yes', comparison_result: comparison_result.map { |supplier_framework, _rates| [supplier_framework.supplier.name, supplier_framework.supplier.id] })
      end

      def self.find_search(framework, user, session_id, params)
        search_criteria_hash = Digest::SHA256.hexdigest(sanatize_search_criteria(LegalPanelForGovernment::Journey.new(framework.id, 'supplier-results', params).params.to_hash).to_s)

        find_by(framework_id: framework.id, user_id: user.id, session_id: session_id, search_criteria_hash: search_criteria_hash)
      end
    end
  end
end

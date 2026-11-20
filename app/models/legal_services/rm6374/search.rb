module LegalServices
  module RM6374
    class Search < ::Search
      store_accessor :additional_details, %i[results_downloaded results_reviewed comparison_result call_off_mechanism]

      def self.log_results_downloaded_to_search(user, session_id)
        search = find_latest_search(user, session_id)

        return unless search && search.results_downloaded.nil?

        search.update!(results_downloaded: true)
      end

      def self.log_call_off_mechanism(user, session_id, params)
        search = find_latest_search(user, session_id)
        return unless search

        search.update!(call_off_mechanism: (I18n.t("legal_services.rm6374.journey.choose_call_off_mechanism.options.#{params[:call_off_mechanism]}") unless params[:call_off_mechanism].nil?),)
      end

      def self.log_supplier_rates_comparison(user, session_id, params, comparison_result)
        search = find_latest_search(user, session_id)
        return unless search

        mapped_suppliers = comparison_result.map do |supplier_framework, _rates|
          [supplier_framework.supplier.name, supplier_framework.supplier.id]
        end

        search.update!(
          results_reviewed: params[:review_prospectus] == 'yes',
          comparison_result: mapped_suppliers
        )
      end

      def self.find_latest_search(user, session_id)
        where(
          framework_id: 'RM6374',
          user_id: user&.id,
          session_id: session_id
        ).order(created_at: :asc).last
      end
    end
  end
end

module SupplyTeachers
  module RM6238
    module Journey::Results
      extend ActiveSupport::Concern
      include SupplyTeachers::Journey::Results

      private

      def search_result_attributes(branch, point, _daily_rates, fixed_term_length, salary)
        search_result_for(branch).tap do |result|
          result.rate = rate(branch)
          result.distance = point.distance(branch.location)

          supplier_finders_fee(result, fixed_term_length, branch_salary(salary, branch.id), result.rate&./(100.0))
        end
      end
    end
  end
end

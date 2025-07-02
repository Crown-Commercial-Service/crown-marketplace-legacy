module SupplyTeachers
  module RM6238
    module Journey::Results
      extend ActiveSupport::Concern
      include SupplyTeachers::Journey::Results

      private

      def search_result_attributes(branch, point, fixed_term_length, salary)
        search_result_for(branch).tap do |result|
          result.rate = branch.supplier_framework_lot.rates.find_by(position_id: determine_position_id)
          result.distance = point.distance(branch.location)

          supplier_finders_fee(result, fixed_term_length, branch_salary(salary, branch.id), result.rate.rate_as_percentage_decimal)
        end
      end

      def lot_id
        'RM6238.1'
      end
    end
  end
end

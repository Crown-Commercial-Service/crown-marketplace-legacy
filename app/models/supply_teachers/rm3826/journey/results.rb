module SupplyTeachers
  module RM3826
    module Journey::Results
      extend ActiveSupport::Concern
      include SupplyTeachers::Journey::Results

      private

      def supplier_mark_up(result, daily_rate, markup_rate)
        return unless daily_rate && markup_rate
        return if daily_rate.empty?

        mark_up = SupplierMarkUp.new(daily_rate: daily_rate, markup_rate: markup_rate)

        if mark_up.valid?
          result.worker_cost = mark_up.worker_cost
          result.agency_fee = mark_up.agency_fee
        else
          result.error = true
        end
      end

      def search_result_attributes(branch, point, daily_rates, fixed_term_length, salary)
        search_result_for(branch).tap do |result|
          result.rate = rate(branch)
          result.distance = point.distance(branch.location)
          result.daily_rate = daily_rates.fetch(branch.id, nil)

          supplier_mark_up(result, result.daily_rate, result.rate)
          supplier_finders_fee(result, fixed_term_length, branch_salary(salary, branch.id), result.rate)
        end
      end
    end
  end
end

module SupplyTeachers
  module RM3826
    module Journey::Results
      extend ActiveSupport::Concern
      include BranchesHelper
      include Geolocatable

      def branches(daily_rates = {}, salary = nil, fixed_term_length = nil)
        point = location.point
        Branch.search(point, rates: rates, radius: radius).map do |branch|
          search_result_attributes(branch, point, daily_rates, fixed_term_length, salary)
        end
      end

      def search_result_for(branch)
        BranchSearchResult.new(
          id: branch.id,
          supplier_name: branch.supplier.name,
          name: display_name_for_branch(branch),
          contact_name: branch.contact_name,
          telephone_number: branch.telephone_number,
          contact_email: branch.contact_email,
          slug: branch.slug
        )
      end

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

      def supplier_finders_fee(result, fixed_term_length, salary, fixed_term_rate)
        return unless fixed_term_length && salary
        return if fixed_term_length.nil? || salary.empty?

        finders_fee = SupplierFindersFee.new(fixed_term_length: fixed_term_length, salary: salary, fixed_term_rate: fixed_term_rate)

        if finders_fee.valid?
          result.finders_fee = finders_fee.finders_fee
        else
          result.error = true
        end
      end

      def branch_salary(salary, branch_id)
        return unless salary

        salary.is_a?(String) ? salary : salary.fetch(branch_id, nil)
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

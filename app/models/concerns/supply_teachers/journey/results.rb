module SupplyTeachers
  module Journey::Results
    extend ActiveSupport::Concern
    include Geolocatable

    def branches(salary: nil, fixed_term_length: nil)
      point = location.point

      Supplier::Framework::Lot::Branch.search(point, lot_id: lot_id, position_id: determine_position_id, radius: radius).map do |branch|
        search_result_attributes(branch, point, fixed_term_length, salary)
      end
    end

    def search_result_for(branch)
      BranchSearchResult.new(
        id: branch.id,
        supplier_name: branch.supplier_name,
        name: display_name_for_branch(branch),
        contact_name: branch.contact_name,
        telephone_number: branch.telephone_number,
        contact_email: branch.contact_email,
        slug: branch.slug
      )
    end

    private

    def supplier_finders_fee(result, fixed_term_length, salary, fixed_term_rate)
      return unless fixed_term_length && salary
      return if fixed_term_length.nil? || salary.empty?

      finders_fee = SupplierFindersFee.new(fixed_term_length:, salary:, fixed_term_rate:)

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

    def display_name_for_branch(branch)
      branch.name.present? ? branch.name : branch.town
    end
  end
end

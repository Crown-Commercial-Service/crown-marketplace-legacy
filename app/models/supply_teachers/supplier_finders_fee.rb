module SupplyTeachers
  class SupplierFindersFee
    include Virtus.model

    attribute :fixed_term_length, Float
    attribute :salary, Integer
    attribute :fixed_term_rate, Float

    def finders_fee
      if fixed_term_length > 12
        salary * fixed_term_rate
      else
        salary * fixed_term_length / 12.0 * fixed_term_rate
      end
    end

    def valid?
      salary.is_a?(Integer) && salary.positive?
    end
  end
end

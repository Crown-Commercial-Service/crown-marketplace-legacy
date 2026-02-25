module SupplyTeachers
  class SupplierFindersFee
    include ActiveModel::Model
    include ActiveModel::Attributes

    attribute :fixed_term_length, :float
    attribute :salary, :numeric
    attribute :fixed_term_rate, :float

    def salary=(value)
      if value.present?
        super(Float(value).round)
      else
        super
      end
    rescue ArgumentError
      super
    end

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

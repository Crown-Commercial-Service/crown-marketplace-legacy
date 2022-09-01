module SupplyTeachers
  module RM3826
    class Journey::TempToPermCalculator < SupplyTeachers::Journey::TempToPermCalculator
      attribute :day_rate
      validates :day_rate, presence: true, numericality: { only_integer: true, greater_than: 0 }

      attribute :markup_rate
      validates :markup_rate,
                presence: true,
                numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
    end
  end
end

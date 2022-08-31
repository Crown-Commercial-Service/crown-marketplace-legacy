module SupplyTeachers
  module RM6238
    class Journey::TempToPermCalculator < SupplyTeachers::Journey::TempToPermCalculator
      attribute :daily_fee
      validates :daily_fee, presence: true, numericality: { greater_than: 0 }, format: /\A^\d+\.?\d{0,2}$\z/
    end
  end
end

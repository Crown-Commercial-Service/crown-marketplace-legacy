module SupplyTeachers::ContractStartable
  extend ActiveSupport::Concern

  included do
    attribute :contract_start_date_day
    attribute :contract_start_date_month
    attribute :contract_start_date_year
    validates :contract_start_date, presence: true
    validate  -> { ensure_date_valid(:contract_start_date, false) }
  end
end

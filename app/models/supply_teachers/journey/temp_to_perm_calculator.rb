module SupplyTeachers
  class Journey::TempToPermCalculator
    DATE_ATTIBUTES = %i[contract_start_date hire_date notice_date holiday_1_start_date holiday_1_end_date holiday_2_start_date holiday_2_end_date].freeze

    include Steppable
    include DateValidator

    attribute :contract_start_date_day
    attribute :contract_start_date_month
    attribute :contract_start_date_year
    validate -> { ensure_date_valid(:contract_start_date, false) }
    validates :contract_start_date, presence: true

    attribute :days_per_week
    validates :days_per_week,
              presence: true,
              numericality: { greater_than: 0, less_than_or_equal_to: 5 }

    attribute :day_rate
    validates :day_rate, presence: true, numericality: { only_integer: true, greater_than: 0 }

    attribute :markup_rate
    validates :markup_rate,
              presence: true,
              numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }

    attribute :hire_date_day
    attribute :hire_date_month
    attribute :hire_date_year
    validate -> { ensure_date_valid(:hire_date, false) }
    validates :hire_date, presence: true

    attribute :holiday_1_start_date_day
    attribute :holiday_1_start_date_month
    attribute :holiday_1_start_date_year
    validate -> { ensure_date_valid(:holiday_1_start_date) }
    validates :holiday_1_start_date,
              presence: {
                if: proc do |calculator|
                  calculator.holiday_1_start_date_day.present? ||
                    calculator.holiday_1_start_date_month.present? ||
                    calculator.holiday_1_start_date_year.present?
                end,
                message: :blank
              }
    validates :holiday_1_start_date,
              presence: {
                if: proc { |calculator| calculator.holiday_1_end_date.present? },
                message: :blank
              }

    attribute :holiday_1_end_date_day
    attribute :holiday_1_end_date_month
    attribute :holiday_1_end_date_year
    validate -> { ensure_date_valid(:holiday_1_end_date) }
    validates :holiday_1_end_date,
              presence: {
                if: proc do |calculator|
                  calculator.holiday_1_end_date_day.present? ||
                    calculator.holiday_1_end_date_month.present? ||
                    calculator.holiday_1_end_date_year.present?
                end,
                message: :blank
              }
    validates :holiday_1_end_date,
              presence: {
                if: proc { |calculator| calculator.holiday_1_start_date.present? },
                message: :blank
              }
    validate -> { ensure_date_is_after(holiday_1_end_date, holiday_1_start_date, :holiday_1_end_date, :before_start_date) }

    attribute :holiday_2_start_date_day
    attribute :holiday_2_start_date_month
    attribute :holiday_2_start_date_year
    validate -> { ensure_date_valid(:holiday_2_start_date) }
    validates :holiday_2_start_date,
              presence: {
                if: proc do |calculator|
                  calculator.holiday_2_start_date_day.present? ||
                    calculator.holiday_2_start_date_month.present? ||
                    calculator.holiday_2_start_date_year.present?
                end,
                message: :blank
              }

    validates :holiday_2_start_date,
              presence: {
                if: proc { |calculator| calculator.holiday_2_end_date.present? },
                message: :blank
              }
    attribute :holiday_2_end_date_day
    attribute :holiday_2_end_date_month
    attribute :holiday_2_end_date_year
    validate -> { ensure_date_valid(:holiday_2_end_date) }
    validates :holiday_2_end_date,
              presence: {
                if: proc do |calculator|
                  calculator.holiday_2_end_date_day.present? ||
                    calculator.holiday_2_end_date_month.present? ||
                    calculator.holiday_2_end_date_year.present?
                end,
                message: :blank
              }
    validates :holiday_2_end_date,
              presence: {
                if: proc { |calculator| calculator.holiday_2_start_date.present? },
                message: :blank
              }
    validate -> { ensure_date_is_after(holiday_2_end_date, holiday_2_start_date, :holiday_2_end_date, :before_start_date) }

    attribute :notice_date_day
    attribute :notice_date_month
    attribute :notice_date_year
    validate -> { ensure_date_valid(:notice_date) }
    validates :notice_date,
              presence: {
                if: proc do |calculator|
                  calculator.notice_date_day.present? ||
                    calculator.notice_date_month.present? ||
                    calculator.notice_date_year.present?
                end,
                message: :blank
              }

    validate -> { ensure_date_is_after(hire_date, contract_start_date, :hire_date, :after_contract_start_date) }
    validate -> { ensure_date_is_after(notice_date, contract_start_date, :notice_date, :before_contract_start_date) }
    validate :ensure_notice_date_is_before_hire_date

    def next_step_class
      service_name::Journey::TempToPermFee
    end

    private

    def ensure_notice_date_is_before_hire_date
      return if notice_date.blank? || hire_date.blank?
      return if notice_date <= hire_date

      errors.add(:notice_date, :after_hire_date)
    end
  end
end

module SupplyTeachers::RM6238::TempToPermCalculator
  class Calculator < SupplyTeachers::TempToPermCalculator::Calculator
    DATE_NATIONAL_DEAL_BEGAN = Date.parse('5 July 2022')

    def initialize(
      days_per_week:,
      contract_start_date:,
      hire_date:,
      daily_fee:,
      notice_date: nil,
      holiday_1_start_date: nil,
      holiday_1_end_date: nil,
      holiday_2_start_date: nil,
      holiday_2_end_date: nil
    )
      super(
        days_per_week: days_per_week,
        contract_start_date: contract_start_date,
        hire_date: hire_date,
        daily_fee: daily_fee,
        notice_date: notice_date,
        holiday_1_start_date: holiday_1_start_date,
        holiday_1_end_date: holiday_1_end_date,
        holiday_2_start_date: holiday_2_start_date,
        holiday_2_end_date: holiday_2_end_date,
        day_rate: nil,
        markup_rate: nil
      )
    end

    def daily_supplier_fee
      @daily_fee
    end
  end
end

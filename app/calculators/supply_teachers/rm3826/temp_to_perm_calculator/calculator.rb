module SupplyTeachers::RM3826::TempToPermCalculator
  class Calculator < SupplyTeachers::TempToPermCalculator::Calculator
    DATE_NATIONAL_DEAL_BEGAN = Date.parse('23 Aug 2018')

    def initialize(
      day_rate:,
      days_per_week:,
      contract_start_date:,
      hire_date:,
      markup_rate:,
      notice_date: nil,
      holiday_1_start_date: nil,
      holiday_1_end_date: nil,
      holiday_2_start_date: nil,
      holiday_2_end_date: nil
    )
      super(
        day_rate: day_rate,
        days_per_week: days_per_week,
        contract_start_date: contract_start_date,
        hire_date: hire_date,
        markup_rate: markup_rate,
        notice_date: notice_date,
        holiday_1_start_date: holiday_1_start_date,
        holiday_1_end_date: holiday_1_end_date,
        holiday_2_start_date: holiday_2_start_date,
        holiday_2_end_date: holiday_2_end_date,
        daily_fee: nil,
      )
    end

    def daily_supplier_fee
      @day_rate - (@day_rate / (1 + @markup_rate))
    end
  end
end

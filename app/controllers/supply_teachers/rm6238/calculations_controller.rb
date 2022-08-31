module SupplyTeachers
  module RM6238
    class CalculationsController < SupplyTeachers::CalculationsController
      def calculator(previous_step)
        TempToPermCalculator::Calculator.new(
          days_per_week: previous_step.days_per_week.to_i,
          contract_start_date: previous_step.contract_start_date,
          hire_date: previous_step.hire_date,
          daily_fee: previous_step.daily_fee.to_f,
          notice_date: previous_step.notice_date,
          holiday_1_start_date: previous_step.holiday_1_start_date,
          holiday_1_end_date: previous_step.holiday_1_end_date,
          holiday_2_start_date: previous_step.holiday_2_start_date,
          holiday_2_end_date: previous_step.holiday_2_end_date
        )
      end
    end
  end
end

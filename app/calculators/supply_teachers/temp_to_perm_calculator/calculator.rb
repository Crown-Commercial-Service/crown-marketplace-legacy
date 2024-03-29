module SupplyTeachers::TempToPermCalculator
  class Calculator
    WORKING_DAYS_BEFORE_WHICH_EARLY_HIRE_FEE_CAN_BE_CHARGED = 60
    WORKING_DAYS_AFTER_WHICH_LATE_NOTICE_FEE_CAN_BE_CHARGED = 40
    WORKING_DAYS_NOTICE_PERIOD_REQUIRED_TO_AVOID_LATE_NOTICE_FEE = 20
    MAXIMUM_NUMBER_OF_WORKING_DAYS_PER_WEEK = 5

    attr_reader :day_rate, :days_per_week, :contract_start_date, :hire_date, :markup_rate, :notice_date

    def initialize(
      day_rate:,
      days_per_week:,
      contract_start_date:,
      hire_date:,
      markup_rate:,
      daily_fee:,
      notice_date: nil,
      holiday_1_start_date: nil,
      holiday_1_end_date: nil,
      holiday_2_start_date: nil,
      holiday_2_end_date: nil
    )
      raise(ArgumentError, 'Hire date cannot be earlier than contract start date') if hire_date < contract_start_date
      raise(ArgumentError, 'Notice date cannot be later than hire date') if notice_date && notice_date > hire_date
      raise(ArgumentError, 'Notice date cannot be earlier than contract start date') if notice_date && notice_date < contract_start_date

      @day_rate = day_rate
      @days_per_week = days_per_week
      @contract_start_date = contract_start_date
      @hire_date = hire_date
      @markup_rate = markup_rate
      @daily_fee = daily_fee
      @notice_date = notice_date
      @working_days = WorkingDays.new(holiday_1_start_date, holiday_1_end_date, holiday_2_start_date, holiday_2_end_date)
    end

    def maximum_fee_for_lack_of_notice
      WORKING_DAYS_NOTICE_PERIOD_REQUIRED_TO_AVOID_LATE_NOTICE_FEE * pro_rata_daily_supplier_fee
    end

    def days_notice_required
      WORKING_DAYS_NOTICE_PERIOD_REQUIRED_TO_AVOID_LATE_NOTICE_FEE
    end

    def days_notice_given
      @working_days.between(@notice_date, @hire_date)
    end

    def hiring_within_8_weeks?
      end_of_8th_working_week = @working_days.after(@contract_start_date,
                                                    WORKING_DAYS_AFTER_WHICH_LATE_NOTICE_FEE_CAN_BE_CHARGED - 1)
      @hire_date <= end_of_8th_working_week
    end

    def hiring_between_9_and_12_weeks?
      start_of_9th_working_week = @working_days.after(@contract_start_date,
                                                      WORKING_DAYS_AFTER_WHICH_LATE_NOTICE_FEE_CAN_BE_CHARGED)
      end_of_12th_working_week = @working_days.after(@contract_start_date,
                                                     WORKING_DAYS_BEFORE_WHICH_EARLY_HIRE_FEE_CAN_BE_CHARGED - 1)

      (start_of_9th_working_week..end_of_12th_working_week).cover?(@hire_date)
    end

    def hiring_after_12_weeks?
      start_of_13th_working_week = @working_days.after(@contract_start_date,
                                                       WORKING_DAYS_BEFORE_WHICH_EARLY_HIRE_FEE_CAN_BE_CHARGED)
      @hire_date >= start_of_13th_working_week
    end

    def enough_notice?
      chargeable_working_days_based_on_lack_of_notice.zero?
    end

    def fee
      [
        chargeable_working_days * pro_rata_daily_supplier_fee,
        0
      ].max
    end

    def chargeable_working_days
      if notice_period_required?
        [
          chargeable_working_days_based_on_early_hire + chargeable_working_days_based_on_lack_of_notice,
          20
        ].min
      else
        chargeable_working_days_based_on_early_hire
      end
    end

    def chargeable_working_days_based_on_early_hire
      chargeable_working_days = WORKING_DAYS_BEFORE_WHICH_EARLY_HIRE_FEE_CAN_BE_CHARGED - working_days_count
      chargeable_working_days.negative? ? 0 : chargeable_working_days
    end

    def chargeable_working_days_based_on_lack_of_notice
      return 0 unless notice_period_required?
      return 0 unless @notice_date
      return 0 if @notice_date <= notice_date_based_on_hire_date

      @working_days.between(notice_date_based_on_hire_date, @notice_date)
    end

    def pro_rata_daily_supplier_fee
      daily_supplier_fee * (@days_per_week / MAXIMUM_NUMBER_OF_WORKING_DAYS_PER_WEEK.to_f)
    end

    def working_days_count
      @working_days.between(@contract_start_date, @hire_date)
    end

    def ideal_hire_date
      @working_days.after(early_hire_fee_can_be_charged_until, 1)
    end

    def ideal_notice_date
      @working_days.before(ideal_hire_date, WORKING_DAYS_NOTICE_PERIOD_REQUIRED_TO_AVOID_LATE_NOTICE_FEE)
    end

    def before_national_deal_began?
      contract_start_date < self.class::DATE_NATIONAL_DEAL_BEGAN
    end

    def notice_date_based_on_hire_date
      return nil unless notice_period_required?

      @working_days.before(@hire_date, 20)
    end

    def notice_period_required?
      hire_date >= late_notice_fee_can_be_charged_from
    end

    private

    def late_notice_fee_can_be_charged_from
      @working_days.after(@contract_start_date, WORKING_DAYS_AFTER_WHICH_LATE_NOTICE_FEE_CAN_BE_CHARGED)
    end

    def early_hire_fee_can_be_charged_until
      @working_days.after(@contract_start_date, WORKING_DAYS_BEFORE_WHICH_EARLY_HIRE_FEE_CAN_BE_CHARGED - 1)
    end
  end
end

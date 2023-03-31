module SupplyTeachers::TempToPermCalculatorHelper
  TRANSLATION_SCOPE = 'supply_teachers.calculations.temp_to_perm_fee.calculations'.freeze

  def display_notice_period_required(calculator)
    t("#{TRANSLATION_SCOPE}.notice_period_required",
      days: calculator.days_notice_required)
  end

  def display_notice_period_given(calculator)
    t("#{TRANSLATION_SCOPE}.notice_period_given",
      days: calculator.days_notice_given,
      notice_date: calculator.notice_date.to_fs(:long_with_day),
      hire_date: calculator.hire_date.to_fs(:long_with_day))
  end

  def display_chargeable_days_for_lack_of_notice(calculator)
    t("#{TRANSLATION_SCOPE}.lack_of_notice_chargeable_days",
      count: calculator.chargeable_working_days_based_on_lack_of_notice)
  end

  def display_suppliers_daily_fee(calculator)
    case params[:framework]
    when 'RM6238'
      t("#{TRANSLATION_SCOPE}.daily_supplier_fee_no_markup",
        fee: number_to_currency(calculator.daily_supplier_fee))
    end
  end

  def display_suppliers_pro_rata_daily_fee?(calculator)
    calculator.days_per_week < SupplyTeachers::TempToPermCalculator::Calculator::MAXIMUM_NUMBER_OF_WORKING_DAYS_PER_WEEK
  end

  def display_suppliers_pro_rata_daily_fee(calculator)
    t("#{TRANSLATION_SCOPE}.daily_supplier_fee_pro_rata",
      fee: number_to_currency(calculator.pro_rata_daily_supplier_fee),
      days_per_week: calculator.days_per_week)
  end

  def display_total_fee(calculator)
    t("#{TRANSLATION_SCOPE}.total_fee",
      fee: number_to_currency(calculator.fee))
  end

  def display_working_days(calculator)
    t("#{TRANSLATION_SCOPE}.working_days",
      days: calculator.working_days_count,
      contract_start_date: calculator.contract_start_date.to_fs(:long_with_day),
      hire_date: calculator.hire_date.to_fs(:long_with_day))
  end

  def display_chargeable_days_for_early_hire(calculator)
    t("#{TRANSLATION_SCOPE}.early_hire_chargeable_days",
      count: calculator.chargeable_working_days_based_on_early_hire)
  end

  def display_working_days_required
    t("#{TRANSLATION_SCOPE}.working_days_required")
  end
end

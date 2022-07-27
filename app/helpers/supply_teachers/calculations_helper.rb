module SupplyTeachers::CalculationsHelper
  include SupplyTeachers::TempToPermCalculatorHelper

  def determine_result_partial
    result_partial = 'supply_teachers/calculations/temp_to_perm_fee/'

    if @calculator.hiring_after_12_weeks?
      result_partial +=  'after_12_weeks_and_'
    elsif @calculator.hiring_between_9_and_12_weeks?
      result_partial +=  'between_9_and_12_weeks_and_'
    else
      return "#{result_partial}within_first_8_weeks"
    end

    result_partial += if @calculator.notice_date.present?
                        if @calculator.enough_notice?
                          'enough_notice'
                        else
                          'not_enough_notice'
                        end
                      else
                        'no_notice_date'
                      end

    result_partial
  end
end

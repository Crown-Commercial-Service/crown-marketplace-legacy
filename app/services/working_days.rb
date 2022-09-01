class WorkingDays
  def initialize(holiday_1_start_date, holiday_1_end_date, holiday_2_start_date, holiday_2_end_date)
    generate_school_holidays(holiday_1_start_date, holiday_1_end_date, holiday_2_start_date, holiday_2_end_date)
  end

  def after(date, number_of_days)
    date_from_period(date, number_of_days, '+')
  end

  def before(date, number_of_days)
    date_from_period(date, number_of_days, '-')
  end

  def between(earlier_date, later_date)
    (earlier_date...later_date).select { |date| working_day?(date) }.count
  end

  private

  def date_from_period(date, number_of_days, operation)
    working_days_count = working_day?(date) ? 1 : 0
    while working_days_count <= number_of_days
      date = date.public_send(operation, 1.day)

      working_days_count += 1 if working_day?(date)
    end
    date
  end

  def working_day?(date)
    date.on_weekday? && england_and_wales_bank_holiday?(date) && !@school_holidays.include?(date)
  end

  def generate_school_holidays(holiday_1_start_date, holiday_1_end_date, holiday_2_start_date, holiday_2_end_date)
    @school_holidays = []
    @school_holidays += (holiday_1_start_date..holiday_1_end_date).to_a if holiday_1_start_date && holiday_1_end_date
    @school_holidays += (holiday_2_start_date..holiday_2_end_date).to_a if holiday_2_start_date && holiday_2_end_date
    @school_holidays
  end

  def england_and_wales_bank_holiday?(date)
    england_and_wales_bank_holidays.exclude? date
  end

  def england_and_wales_bank_holidays
    @england_and_wales_bank_holidays ||= bank_holiday_json['england-and-wales']['events'].map { |date| DateTime.parse(date['date']).in_time_zone('London') }
  end

  def bank_holiday_json
    JSON.parse(Net::HTTP.get(URI('https://www.gov.uk/bank-holidays.json')))
  end
end

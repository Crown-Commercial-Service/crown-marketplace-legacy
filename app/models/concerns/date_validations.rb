module DateValidations
  extend ActiveSupport::Concern

  private

  included do
    self::DATE_ATTIBUTES.each do |attribute|
      define_method attribute do
        Date.strptime(
          "#{send("#{attribute}_year")}-#{send("#{attribute}_month")}-#{send("#{attribute}_day")}",
          PARSED_DATE_FORMAT
        )
      rescue ArgumentError
        nil
      end
    end
  end

  PARSED_DATE_FORMAT = '%Y-%m-%d'.freeze

  def ensure_date_valid(attribute, allow_blank = true)
    year = send("#{attribute}_year")
    month = send("#{attribute}_month")
    day = send("#{attribute}_day")

    return if allow_blank && [year, month, day].none?(&:present?)

    errors.add(attribute, :invalid) unless Date.valid_date?(year.to_i, month.to_i, day.to_i)
  end

  def ensure_date_is_after(first_date, second_date, attribute, error)
    return if first_date.blank? || second_date.blank?
    return if first_date >= second_date

    errors.add(attribute, error)
  end
end

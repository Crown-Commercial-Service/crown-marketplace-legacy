module LegalServices::RatesHelper
  def display_rate(position_id, rates)
    return if rates[position_id].nil? || rates[position_id].rate.zero?

    number_to_currency(rates[position_id].normalized_rate, precision: 2)
  end
end

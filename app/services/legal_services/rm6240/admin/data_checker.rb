class LegalServices::RM6240::Admin::DataChecker
  def initialize(supplier_data)
    @supplier_data = supplier_data
  end

  def check_data
    errors = []

    supplier_missing_lots = @supplier_data.select { |supplier| supplier['service_offerings'].empty? }
    supplier_missing_rate_cards = @supplier_data.select { |supplier| supplier['rates'].empty? }

    errors << { error: 'supplier_missing_lots', details: supplier_missing_lots.pluck('name') } if supplier_missing_lots.any?
    errors << { error: 'supplier_missing_rate_cards', details: supplier_missing_rate_cards.pluck('name') } if supplier_missing_rate_cards.any?

    errors
  end
end

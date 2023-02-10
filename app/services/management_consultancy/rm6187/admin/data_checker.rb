class ManagementConsultancy::RM6187::Admin::DataChecker
  def initialize(supplier_data)
    @supplier_data = supplier_data
  end

  def check_data
    errors = []

    supplier_missing_lots = @supplier_data.select { |supplier| supplier['lots'].blank? }
    supplier_missing_rate_cards = @supplier_data.select { |supplier| supplier['rate_cards'].blank? }

    errors << { error: 'supplier_missing_lots', details: supplier_missing_lots.pluck('name') } if supplier_missing_lots.any?
    errors << { error: 'supplier_missing_rate_cards', details: supplier_missing_rate_cards.pluck('name') } if supplier_missing_rate_cards.any?

    errors
  end
end

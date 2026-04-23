class SupplyTeachers::RM6376::Admin::DataChecker < DataChecker
  def check_data
    errors = []

    supplier_missing_lots = fetch_supplier_missing_lots
    supplier_missing_rates = fetch_supplier_missing_rates
    supplier_missing_branches, supplier_missing_branch_data = fetch_supplier_missing_branches

    [
      ['supplier_missing_lots', supplier_missing_lots],
      ['supplier_missing_rates', supplier_missing_rates],
      ['supplier_missing_branches', supplier_missing_branches],
      ['supplier_missing_branch_data', supplier_missing_branch_data],
    ].each do |error_key, supplier_missing_data|
      errors << { error: error_key, details: supplier_missing_data.pluck(:name) } if supplier_missing_data.any?
    end

    errors
  end

  private

  def fetch_supplier_missing_lots
    @supplier_data.select { |supplier| supplier[:supplier_frameworks].any? { |supplier_framework| supplier_framework[:supplier_framework_lots].empty? } }
  end

  def fetch_supplier_missing_rates
    @supplier_data.select { |supplier| supplier[:supplier_frameworks].any? { |supplier_framework| supplier_framework[:supplier_framework_lots].any? { |supplier_framework_lot| supplier_framework_lot[:supplier_framework_lot_rates].empty? } } }
  end

  # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  def fetch_supplier_missing_branches
    supplier_missing_branches = []
    supplier_missing_branch_data = []

    @supplier_data.each do |supplier|
      supplier[:supplier_frameworks].each do |supplier_framework|
        supplier_framework[:supplier_framework_lots].each do |supplier_framework_lot|
          next unless supplier_framework_lot[:lot_id] == 'RM6376.1'

          if supplier_framework_lot[:supplier_framework_lot_branches].empty?
            supplier_missing_branches << supplier
          else
            supplier_framework_lot[:supplier_framework_lot_branches].each do |supplier_framework_lot_branch|
              if supplier_framework_lot_branch.except(:address_line_2, :county).values.any?(&:blank?)
                supplier_missing_branch_data << supplier
                break
              end
            end
          end
        end
      end
    end

    [supplier_missing_branches, supplier_missing_branch_data]
  end
  # rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
end

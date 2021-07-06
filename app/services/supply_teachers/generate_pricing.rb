class SupplyTeachers::GeneratePricing
  include SupplyTeachers::DataImportHelper

  attr_reader :supplier_pricing, :errors

  def initialize(current_data)
    @current_data = current_data
    @errors = []
  end

  def generate_pricing
    @supplier_pricing = collate(pricing)
  end

  private

  # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  def pricing
    pricing_data = []

    read_spreadsheet(@current_data.pricing_for_tool) do |price_workbook|
      mark_up_sheet = price_workbook.sheet('Lot 1 Pricing')
      pricing_data = mark_up_sheet
                     .map            { |row| add_headings(row) }
                     .map.with_index { |row, index| row.merge(line_no: index + 1) }
                     .reject         { |row| subhead?(row) }
                     .map            { |row| strip_fields(row) }
                     .map            { |row| symbolize_job_types(row, 'pricing_for_tool') }
                     .flat_map       { |row| normalize_pricing(row) }
                     .map            { |row| remove_unused_keys(row) }
                     .reject         { |row| invalid_fee?(row) }
                     .map            { |row| nest(row, :pricing) }
    end

    pricing_data
  end
  # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

  def add_headings(row)
    %i[number supplier_name role job_type fee1 fee2 fee3].zip(row).to_h
  end

  def normalize_pricing(row)
    case row[:job_type]
    when :nominated, :fixed_term
      row.merge(fee: row[:fee1])
    else
      [row.merge(term: :one_week, fee: row[:fee1]),
       row.merge(term: :twelve_weeks, fee: row[:fee2]),
       row.merge(term: :more_than_twelve_weeks, fee: row[:fee3])]
    end
  end
end

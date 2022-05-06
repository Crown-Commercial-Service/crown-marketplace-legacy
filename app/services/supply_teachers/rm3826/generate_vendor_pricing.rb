class SupplyTeachers::RM3826::GenerateVendorPricing
  include SupplyTeachers::RM3826::DataImportHelper

  attr_reader :supplier_vendor_pricing, :errors

  def initialize(current_data)
    @current_data = current_data
    @errors = []
  end

  def generate_vendor_pricing
    @supplier_vendor_pricing = collate(pricing)
  end

  private

  # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  def pricing
    mv_pricing = []
    nv_pricing = [
      {
        supplier_name: 'GRI UK',
        job_type: :nominated,
        fee: 0.04
      },
      {
        supplier_name: 'GRI UK',
        job_type: :daily_fee,
        fee: 2.50
      }
    ].map { |row| nest(row, :neutral_vendor_pricing) }

    read_spreadsheet(@current_data.lot_1_and_lot_2_comparisons) do |mv_price_workbook|
      mv_mark_up_sheet = mv_price_workbook.sheet('Sheet1')
      mv_pricing = mv_mark_up_sheet
                   .map            { |row| add_mv_headings(row) }
                   .map.with_index { |row, index| row.merge(line_no: index + 1) }
                   .reject         { |row| subhead?(row) }
                   .map            { |row| strip_fields(row) }
                   .map            { |row| symbolize_job_types(row, 'lot_1_and_2_comparisons') }
                   .flat_map       { |row| normalize_mv_pricing(row) }
                   .map            { |row| remove_unused_keys(row) }
                   .reject         { |row| invalid_fee?(row) }
                   .map            { |row| nest(row, :master_vendor_pricing) }
    end

    mv_pricing + nv_pricing
  end
  # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

  def add_mv_headings(row)
    %i[number supplier_name role job_type lot1_fee1 lot1_fee2 lot1_fee3 blank lot2_fee1 lot2_fee2 lot2_fee3].zip(row).to_h
  end

  def normalize_mv_pricing(row)
    case row[:job_type]
    when :nominated, :fixed_term
      row.merge(fee: row[:lot2_fee1])
    else
      [row.merge(term: :one_week, fee: row[:lot2_fee1]),
       row.merge(term: :twelve_weeks, fee: row[:lot2_fee2]),
       row.merge(term: :more_than_twelve_weeks, fee: row[:lot2_fee3])]
    end
  end
end

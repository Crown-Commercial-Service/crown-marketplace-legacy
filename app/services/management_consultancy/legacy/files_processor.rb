class ManagementConsultancy::Legacy::FilesProcessor < ManagementConsultancy::FilesProcessor
  private

  # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  def add_region_availability_per_lot_per_supplier(regional_offerings_workbook)
    11.times do |sheet_number|
      sheet = regional_offerings_workbook.sheet(sheet_number)
      region_names = sheet.row(1)
      lot_number = sheet_names[sheet.default_sheet]

      (2..sheet.last_row).each do |row_number|
        regional_offerings = {}
        row = sheet.row(row_number)
        supplier_duns = extract_duns(row.first)
        supplier = get_supplier(supplier_duns)
        next unless supplier

        row.each_with_index do |value, index|
          next unless value.to_s.downcase == 'x'

          next if nuts1_region?(region_names[index])

          regional_offerings[extract_region_code(region_names[index])] = 'provided'
        end

        next unless regional_offerings.size.positive?

        supplier_lot = supplier['lots'].detect { |lot| lot['lot_number'] == lot_number }
        supplier_lot['regions'] = regional_offerings if supplier_lot
      end
    end
  end
  # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

  def nuts1_region?(region_name)
    region_code = extract_region_code(region_name)
    /\AUK.\z/.match?(region_code)
  end

  SHEET_NAMES = {
    'MCF Lot 2' => 'MCF1.2',
    'MCF Lot 3' => 'MCF1.3',
    'MCF Lot 4' => 'MCF1.4',
    'MCF Lot 5' => 'MCF1.5',
    'MCF Lot 6' => 'MCF1.6',
    'MCF Lot 7' => 'MCF1.7',
    'MCF Lot 8' => 'MCF1.8',
    'MCF2 Lot 1' => 'MCF2.1',
    'MCF2 Lot 2' => 'MCF2.2',
    'MCF2 Lot 3' => 'MCF2.3',
    'MCF2 Lot 4' => 'MCF2.4',
    'MCF3 Lot 1' => 'MCF3.1',
    'MCF3 Lot 2' => 'MCF3.2',
    'MCF3 Lot 3' => 'MCF3.3',
    'MCF3 Lot 4' => 'MCF3.4',
    'MCF3 Lot 5' => 'MCF3.5',
    'MCF3 Lot 6' => 'MCF3.6',
    'MCF3 Lot 7' => 'MCF3.7',
    'MCF3 Lot 8' => 'MCF3.8',
    'MCF3 Lot 9' => 'MCF3.9'
  }.freeze

  PROCESS_FILES_AND_METHODS = {
    supplier_details_file: :add_suppliers,
    supplier_service_offerings_file: :add_service_offerings_per_supplier,
    supplier_regional_offerings_file: :add_region_availability_per_lot_per_supplier,
    supplier_rate_cards_file: :add_rate_cards_to_suppliers
  }.freeze
end

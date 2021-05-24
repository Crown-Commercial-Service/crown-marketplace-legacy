class SupplyTeachers::GenerateAccreditation
  include SupplyTeachers::DataImportHelper

  attr_reader :supplier_accreditation

  def initialize(current_data)
    @current_data = current_data
  end

  def generate_accreditation
    read_spreadsheet(@current_data.current_accredited_suppliers) do |accredited_suppliers_workbook|
      lot_1_accreditation_sheet = accredited_suppliers_workbook.sheet('Lot 1 - Preferred Supplier List')
      lot_1_accreditation = extract_accreditation(lot_1_accreditation_sheet, 'Supplier Name - Accreditation Held')

      lot_2_accreditation_sheet = accredited_suppliers_workbook.sheet('Lot 2 - Master Vendor MSP')
      lot_2_accreditation = extract_accreditation(lot_2_accreditation_sheet, 'Supplier Name - Accreditation Held')

      lot_3_accreditation_sheet = accredited_suppliers_workbook.sheet('Lot 3 - Neutral Vendor MSP')
      lot_3_accreditation = extract_accreditation(lot_3_accreditation_sheet, 'Supplier Name')

      accreditation = lot_1_accreditation + lot_2_accreditation + lot_3_accreditation

      @supplier_accreditation = accreditation
    end
  end

  private

  def extract_accreditation(sheet, header)
    sheet.parse(header_search: [header])
         .map            { |row| remap_headers(row, HEADER_MAP) }
         .map.with_index { |row, index| row.merge(line_no: index + 1) }
         .reject         { |row| row[:supplier_name].nil? || row[:supplier_name] == '' }
         .map            { |row| strip_fields(row) }
         .map            { |row| add_accreditation(row) }
  end

  def add_accreditation(row)
    row.merge(accreditation: true)
  end

  HEADER_MAP = {
    'Supplier Name - Accreditation Held' => :supplier_name,
    'Supplier Name' => :supplier_name
  }.freeze
end

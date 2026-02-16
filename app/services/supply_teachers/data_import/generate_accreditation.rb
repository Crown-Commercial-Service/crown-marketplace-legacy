module SupplyTeachers
  class DataImport::GenerateAccreditation
    include SupplyTeachers::DataImport::Helper

    attr_reader :supplier_accreditation

    def initialize(current_data)
      @current_data = current_data
    end

    def generate_accreditation
      read_spreadsheet(@current_data.current_accredited_suppliers) do |accredited_suppliers_workbook|
        @supplier_accreditation = self.class::SHEETS_AND_TITLES.map do |sheet_name, heading|
          accreditation_sheet = accredited_suppliers_workbook.sheet(sheet_name)

          extract_accreditation(accreditation_sheet, heading)
        end.flatten
      end
    end

    private

    def extract_accreditation(sheet, header)
      sheet.parse(header_search: [header])
           .map            { |row| remap_headers(row, HEADER_MAP) }
           .map.with_index { |row, index| row.merge(line_no: index + 1) }
               .reject { |row| row[:supplier_name].nil? || row[:supplier_name] == '' }
               .map { |row| strip_fields(row) }
               .map { |row| add_accreditation(row) }
    end

    def add_accreditation(row)
      row.merge(accreditation: true)
    end

    HEADER_MAP = {
      'Supplier Name - Accreditation Held' => :supplier_name,
      'Supplier Name' => :supplier_name
    }.freeze
  end
end

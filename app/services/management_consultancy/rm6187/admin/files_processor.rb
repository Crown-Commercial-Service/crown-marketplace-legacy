class ManagementConsultancy::RM6187::Admin::FilesProcessor < FilesProcessor
  private

  def add_suppliers(suppliers_workbook)
    headers = {
      name: 'Supplier name',
      email: 'Email address',
      telephone_number: 'Phone number',
      website: 'Website URL',
      address: 'Postal address',
      sme: 'Is an SME?',
      duns: 'DUNS Number',
      clean: true
    }

    supplier_data = []

    number_of_sheets(suppliers_workbook).times { |index| supplier_data += suppliers_workbook.sheet(index).parse(headers).map(&:stringify_keys!) }

    supplier_data.delete_if { |supplier| supplier['duns'].nil? }

    supplier_data.uniq! { |supplier| supplier['duns'] }

    @supplier_data = supplier_data.map do |supplier|
      {
        id: SecureRandom.uuid,
        name: supplier['name'],
        duns_number: supplier['duns'],
        sme: ['YES', 'Y'].include?(supplier['sme'].to_s.upcase),
        supplier_frameworks: [
          {
            framework_id: 'RM6187',
            enabled: true,
            supplier_framework_contact_detail: {
              email: supplier['email'],
              telephone_number: supplier['telephone_number'],
              website: supplier['website'],
              additional_details: {
                address: supplier['address'],
              }
            },
            supplier_framework_lots_data: {},
            supplier_framework_lots: []
          }
        ]
      }
    end
  end

  def add_service_offerings_per_supplier(service_offerings_workbook)
    number_of_sheets(service_offerings_workbook).times do |sheet_number|
      sheet = service_offerings_workbook.sheet(sheet_number)
      service_names = sheet.column(1)

      (2..sheet.last_column).each do |column_number|
        column = sheet.column(column_number)
        supplier_duns = extract_duns(column.first)
        supplier = get_supplier(supplier_duns)
        next unless supplier

        add_services(supplier, service_names, column)
      end
    end
  end

  def add_services(supplier, service_names, column)
    supplier_framework_lots_data = supplier[:supplier_frameworks][0][:supplier_framework_lots_data]

    column.each_with_index do |value, index|
      next unless value.to_s.downcase == 'x'

      next if service_names[index].nil?

      next if zero_number_service_line?(service_names[index])

      service_number_parts = extract_service_number(service_names[index]).split('.')

      service_id = "RM6187.#{service_number_parts[1]}.#{service_number_parts[2]}"
      lot_id = "RM6187.#{service_number_parts[1]}"

      supplier_framework_lots_data[lot_id] ||= { services: [], rates: [], jurisdictions: [], branches: [] }
      supplier_framework_lots_data[lot_id][:services] << { service_id: }
    end
  end

  def add_rate_cards_to_suppliers(rate_cards_workbook)
    number_of_sheets(rate_cards_workbook).times do |sheet_number|
      sheet = rate_cards_workbook.sheet(sheet_number)
      lot_id = "RM6187.#{sheet_names[sheet.default_sheet].split('.')[1]}"

      (2..sheet.last_row).each do |row_number|
        row = sheet.row(row_number)
        supplier_duns = extract_duns(row.first)
        supplier = get_supplier(supplier_duns)
        next unless supplier

        add_rates(supplier, row, lot_id)
      end
    end
  end

  def add_rates(supplier, row, lot_id)
    supplier_framework_lots_data = supplier[:supplier_frameworks][0][:supplier_framework_lots_data]

    row[1..6].each.with_index(8) do |rate, position_id|
      supplier_framework_lots_data[lot_id] ||= { services: [], rates: [], jurisdictions: [], branches: [] }
      supplier_framework_lots_data[lot_id][:rates] << {
        position_id: position_id,
        rate: convert_price(rate),
      }
    end

    supplier[:supplier_frameworks][0][:supplier_framework_contact_detail][:name] ||= row[7]
  end

  def zero_number_service_line?(service_name)
    service_number = extract_service_number(service_name)
    /\.0\z/.match? service_number
  end

  def convert_price(price)
    price.to_s.gsub(',', '').to_i * 100
  end

  def sheet_names
    self.class::SHEET_NAMES
  end

  SHEET_NAMES = {
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
    supplier_rate_cards_file: :add_rate_cards_to_suppliers
  }.freeze
end

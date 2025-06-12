class ManagementConsultancy::RM6309::Admin::FilesProcessor
  include FilesImporterHelper

  def initialize(upload)
    @upload = upload
    @supplier_data = []
  end

  def process_files
    process_files_and_methods.each do |file, check_method|
      read_spreadsheet(file) do |workbook|
        send(check_method, workbook)
      end
    end

    @supplier_data
  end

  private

  def add_suppliers(suppliers_workbook)
    headers = {
      name: 'Supplier name',
      contact_name: 'Contact name',
      contact_email: 'Email address',
      telephone_number: 'Phone number',
      website: 'Website URL',
      address: 'Postal address',
      sme: 'Is an SME?',
      duns: 'DUNS Number',
      clean: true
    }

    number_of_sheets(suppliers_workbook).times { |index| @supplier_data += suppliers_workbook.sheet(index).parse(headers).map(&:stringify_keys!) }

    @supplier_data.delete_if { |supplier| supplier['duns'].nil? }

    @supplier_data.uniq! { |supplier| supplier['duns'] }

    @supplier_data.each do |supplier|
      supplier['sme'] = ['YES', 'Y'].include? supplier['sme'].to_s.upcase
      supplier['id'] = SecureRandom.uuid
    end
  end

  # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  def add_service_offerings_per_supplier(service_offerings_workbook)
    @supplier_data.each { |supplier| supplier['lots'] = [] }

    number_of_sheets(service_offerings_workbook).times do |sheet_number|
      sheet = service_offerings_workbook.sheet(sheet_number)
      service_names = sheet.column(1)
      lot_number = extract_service_number(service_names[1]).match(/MCF\d[.]\d+/).to_s

      (2..sheet.last_column).each do |column_number|
        service_offerings = []
        column = sheet.column(column_number)
        supplier_duns = extract_duns(column.first)
        supplier = get_supplier(supplier_duns)
        next unless supplier

        column.each_with_index do |value, index|
          next unless value.to_s.downcase == 'x'

          next if service_names[index].nil?

          next if zero_number_service_line?(service_names[index])

          service_offerings << extract_service_number(service_names[index])
        end

        next unless service_offerings.size.positive?

        supplier['lots'] << { 'lot_number' => lot_number, 'services' => service_offerings }
      end
    end
  end

  def add_rate_cards_to_suppliers(rate_cards_workbook)
    @supplier_data.each do |supplier|
      supplier['rate_cards'] = []
    end

    number_of_sheets(rate_cards_workbook).times do |sheet_number|
      sheet = rate_cards_workbook.sheet(sheet_number)
      lot_number = sheet_names[sheet.default_sheet]

      (2..sheet.last_row).each do |row_number|
        row = sheet.row(row_number)
        supplier_duns = extract_duns(row.first)
        supplier = get_supplier(supplier_duns)
        next unless supplier

        rate_cards = {
          advice: {
            lot: lot_number,
            rate_type: 'Advice'
          },
          delivery: {
            lot: lot_number,
            rate_type: 'Delivery'
          }
        }

        if lot_number == 'MCF4.10'
          rate_cards[:advice][:rate_type] = 'Complex'
          rate_cards[:delivery][:rate_type] = 'Non-Complex'
        end

        rate_cards.values.each.with_index do |rate_card, index|
          %i[junior_rate_in_pence standard_rate_in_pence senior_rate_in_pence principal_rate_in_pence managing_rate_in_pence director_rate_in_pence].each.with_index(1) do |rate_type, jndex|
            rate_card[rate_type] = convert_price(row[(index * 6) + jndex])
          end
        end

        supplier['rate_cards'] << rate_cards[:advice]
        supplier['rate_cards'] << rate_cards[:delivery]
      end
    end
  end
  # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

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

  def process_files_and_methods
    self.class::PROCESS_FILES_AND_METHODS
  end

  SHEET_NAMES = {
    'MCF4 Lot 1' => 'MCF4.1',
    'MCF4 Lot 2' => 'MCF4.2',
    'MCF4 Lot 3' => 'MCF4.3',
    'MCF4 Lot 4' => 'MCF4.4',
    'MCF4 Lot 5' => 'MCF4.5',
    'MCF4 Lot 6' => 'MCF4.6',
    'MCF4 Lot 7' => 'MCF4.7',
    'MCF4 Lot 8' => 'MCF4.8',
    'MCF4 Lot 9' => 'MCF4.9',
    'MCF4 Lot 10' => 'MCF4.10'
  }.freeze

  PROCESS_FILES_AND_METHODS = {
    supplier_details_file: :add_suppliers,
    supplier_service_offerings_file: :add_service_offerings_per_supplier,
    supplier_rate_cards_file: :add_rate_cards_to_suppliers
  }.freeze
end

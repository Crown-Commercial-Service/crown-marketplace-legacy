class LegalServices::RM3788::Admin::FilesProcessor
  include FilesImporterHelper

  def initialize(upload)
    @upload = upload
    @supplier_data = []
  end

  def process_files
    PROCESS_FILES_AND_METHODS.each do |file, check_method|
      read_spreadsheet(file) do |workbook|
        send(check_method, workbook)
      end
    end

    @supplier_data
  end

  private

  def add_suppliers(suppliers_workbook)
    headers = {
      name: 'Supplier Name',
      email: 'Email address',
      phone_number: 'Phone number',
      website: 'Website URL',
      address: 'Postal address',
      sme: 'Is an SME',
      duns: 'DUNS Number',
      lot_1_prospectus_link: 'Lot 1: Prospectus Link',
      lot_2_prospectus_link: 'Lot 2: Prospectus Link',
      lot_3_prospectus_link: 'Lot 3: Prospectus Link',
      lot_4_prospectus_link: 'Lot 4: Prospectus Link',
      clean: true
    }

    @supplier_data = suppliers_workbook.sheet(0).parse(headers).map(&:stringify_keys!)

    @supplier_data.each do |supplier|
      supplier['sme'] = ['YES', 'Y'].include? supplier['sme'].to_s.upcase
      supplier['id'] = SecureRandom.uuid
    end
  end

  # rubocop:disable Metrics/AbcSize
  def add_lot_1_services_per_supplier(lot_1_services)
    @supplier_data.each { |supplier| supplier['lot_1_services'] = [] }

    13.times do |sheet_number|
      sheet = lot_1_services.sheet(sheet_number)
      service_names = sheet.column(1)
      region_code = extract_nuts_code(sheet.default_sheet)

      (2..sheet.last_column).each do |column_number|
        column = sheet.column(column_number)
        supplier_duns = extract_duns(column.first)
        supplier = get_supplier(supplier_duns)
        next unless supplier

        column.each_with_index do |value, index|
          next unless value.to_s.downcase == 'x'

          next if service_names[index].nil?

          supplier['lot_1_services'] << { 'service_code' => extract_service_number(service_names[index]), 'region_code' => region_code }
        end
      end
    end
  end

  def add_lot_2_services_per_supplier(lot_2_services)
    @supplier_data.each { |supplier| supplier['lots'] = [] }

    3.times do |sheet_number|
      sheet = lot_2_services.sheet(sheet_number)
      lot_number = extract_lot_number(sheet.default_sheet)
      service_names = sheet.column(1)

      (2..sheet.last_column).each do |column_number|
        service_codes = []
        column = sheet.column(column_number)
        supplier_duns = extract_duns(column.first)
        supplier = get_supplier(supplier_duns)
        next unless supplier

        column.each_with_index do |value, index|
          next unless value.to_s.downcase == 'x'

          next if service_names[index].nil?

          service_codes << extract_service_number(service_names[index])
        end

        supplier['lots'] << { 'lot_number' => lot_number, 'services' => service_codes }
      end
    end
  end
  # rubocop:enable Metrics/AbcSize

  def add_lot_3_services_per_supplier(lot_3_services)
    add_lot_3_and_4_services_per_supplier(lot_3_services, 3, 'WPSLS.3.1')
  end

  def add_lot_4_services_per_supplier(lot_4_services)
    add_lot_3_and_4_services_per_supplier(lot_4_services, 4, 'WPSLS.4.1')
  end

  def add_lot_3_and_4_services_per_supplier(workbook, lot_number, services)
    sheet = workbook.sheet(0)

    (2..sheet.last_column).each do |column_number|
      column = sheet.column(column_number)
      supplier_duns = extract_duns(column.first)
      supplier = get_supplier(supplier_duns)
      next unless supplier

      supplier['lots'] << { 'lot_number' => lot_number, 'services' => [services] }
    end
  end

  def add_rate_cards_to_suppliers(rate_cards_workbook)
    @supplier_data.each { |supplier| supplier['rate_cards'] = [] }
    lot_numbers = ['1', '2a', '2b', '2c', '3', '4']

    6.times do |sheet_number|
      sheet = rate_cards_workbook.sheet(sheet_number)

      (3..sheet.last_row).each do |row_number|
        row = sheet.row(row_number)
        supplier_duns = extract_duns(row.first)
        supplier = get_supplier(supplier_duns)
        next unless supplier

        rate_card = {}
        rate_card['lot'] = lot_numbers[sheet_number]

        rate_card.merge!(extract_rates(row, sheet_number))

        supplier['rate_cards'] << rate_card
      end
    end
  end

  def extract_rates(row, sheet_number)
    rate_card = {}

    LEGAL_LEVELS.each_with_index do |level, index|
      next if sheet_number.zero? && level == 'trainee'

      rate_card[level] = {}
      rate_card[level]['hourly'] = convert_price_to_pence row[(index * 3) + 1]
      rate_card[level]['daily'] = convert_price_to_pence row[(index * 3) + 2]
      rate_card[level]['monthly'] = convert_price_to_pence row[(index * 3) + 3]
    end

    rate_card
  end

  LEGAL_LEVELS = ['managing', 'senior', 'solicitor', 'junior', 'trainee'].freeze

  def extract_nuts_code(sheet_name)
    return 'UK' if sheet_name == 'Full UK Coverage'

    "UK#{sheet_name.split('(NUTS')[1].split(')')[0].strip}"
  end

  def extract_lot_number(sheet_name)
    sheet_name.split('Lot')[1].split('-')[0].strip
  end

  def convert_price_to_pence(price)
    (price * 100).to_i
  end

  PROCESS_FILES_AND_METHODS = {
    supplier_details_file: :add_suppliers,
    supplier_lot_1_service_offerings_file: :add_lot_1_services_per_supplier,
    supplier_lot_2_service_offerings_file: :add_lot_2_services_per_supplier,
    supplier_lot_3_service_offerings_file: :add_lot_3_services_per_supplier,
    supplier_lot_4_service_offerings_file: :add_lot_4_services_per_supplier,
    supplier_rate_cards_file: :add_rate_cards_to_suppliers
  }.freeze
end

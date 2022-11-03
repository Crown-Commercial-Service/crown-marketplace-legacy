class LegalServices::RM6240::Admin::FilesProcessor
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
      clean: true
    }

    @supplier_data = suppliers_workbook.sheet(0).parse(headers).map(&:stringify_keys!)

    @supplier_data.each do |supplier|
      supplier['sme'] = ['YES', 'Y'].include? supplier['sme'].to_s.upcase
      supplier['id'] = SecureRandom.uuid
      supplier['service_offerings'] = []
      supplier['rates'] = []
    end
  end

  def add_lot_services_per_supplier(lot_services)
    3.times do |sheet_number|
      sheet = lot_services.sheet(sheet_number)
      service_codes = sheet.column(2)[2..].map(&:to_s)
      jurisdiction = ('a'..'c').to_a[sheet_number]

      add_service_offerings(sheet, service_codes, jurisdiction)
    end
  end

  def add_lot_3_services_per_supplier(lot_3_services)
    sheet = lot_3_services.sheet(0)
    service_codes = sheet.column(2)[2..].map(&:to_s)

    add_service_offerings(sheet, service_codes)
  end

  def add_service_offerings(sheet, service_codes, jurisdiction = nil)
    (3..sheet.last_column).each do |column_number|
      column = sheet.column(column_number)
      supplier_duns = column[1].to_i
      supplier = get_supplier(supplier_duns)
      next unless supplier

      column[2..].each_with_index do |value, index|
        next unless value.to_s.downcase == 'x'

        next if service_codes[index].nil?

        service_offering = { 'service_code' => service_codes[index] }
        service_offering['jurisdiction'] = jurisdiction if jurisdiction

        supplier['service_offerings'] << service_offering
      end
    end
  end

  def add_rate_cards_to_suppliers(rate_cards_workbook)
    7.times do |sheet_number|
      sheet = rate_cards_workbook.sheet(sheet_number)

      (3..sheet.last_row).each do |row_number|
        row = sheet.row(row_number)
        supplier_duns = row.second.to_i
        supplier = get_supplier(supplier_duns)
        next unless supplier

        create_rate_card(supplier, row, sheet_number)
      end
    end
  end

  def create_rate_card(supplier, row, sheet_number)
    base_rate_card = {}
    base_rate_card['lot_number'] = LOT_NUMBERS[sheet_number][0]
    base_rate_card['jurisdiction'] = LOT_NUMBERS[sheet_number][1]

    row[2..].each.with_index(1) do |rate, position|
      rate_card = base_rate_card.merge({ 'position' => position.to_s, 'rate' => convert_rate_to_pence(rate) })

      supplier['rates'] << rate_card
    end
  end

  def convert_rate_to_pence(rate)
    rate&.*(100).to_i
  end

  LOT_NUMBERS = ['1a', '1b', '1c', '2a', '2b', '2c', '3'].freeze

  PROCESS_FILES_AND_METHODS = {
    supplier_details_file: :add_suppliers,
    supplier_lot_1_service_offerings_file: :add_lot_services_per_supplier,
    supplier_lot_2_service_offerings_file: :add_lot_services_per_supplier,
    supplier_lot_3_service_offerings_file: :add_lot_3_services_per_supplier,
    supplier_rate_cards_file: :add_rate_cards_to_suppliers
  }.freeze
end

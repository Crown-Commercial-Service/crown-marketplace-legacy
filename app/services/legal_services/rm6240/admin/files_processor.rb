class LegalServices::RM6240::Admin::FilesProcessor < FilesProcessor
  private

  def add_suppliers(suppliers_workbook)
    headers = {
      name: 'Supplier Name',
      email: 'Email address',
      telephone_number: 'Phone number',
      website: 'Website URL',
      address: 'Postal address',
      sme: 'Is an SME',
      duns: 'DUNS Number',
      lot_1_prospectus_link: 'Lot 1: Prospectus Link',
      lot_2_prospectus_link: 'Lot 2: Prospectus Link',
      lot_3_prospectus_link: 'Lot 3: Prospectus Link',
      clean: true
    }

    @supplier_data = suppliers_workbook.sheet(0).parse(headers).map(&:stringify_keys!).map do |supplier|
      {
        id: SecureRandom.uuid,
        name: supplier['name'],
        duns_number: supplier['duns'].to_i.to_s,
        sme: ['YES', 'Y'].include?(supplier['sme'].to_s.upcase),
        supplier_frameworks: [
          {
            framework_id: 'RM6240',
            enabled: true,
            supplier_framework_contact_detail: {
              email: supplier['email'],
              telephone_number: supplier['telephone_number'],
              website: supplier['website'],
              additional_details: {
                address: supplier['address'],
                lot_1_prospectus_link: supplier['lot_1_prospectus_link'],
                lot_2_prospectus_link: supplier['lot_2_prospectus_link'],
                lot_3_prospectus_link: supplier['lot_3_prospectus_link'],
              }
            },
            supplier_framework_lots_data: {},
            supplier_framework_lots: []
          }
        ]
      }
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
      supplier_duns = column[1].to_i.to_s
      supplier = get_supplier(supplier_duns)
      next unless supplier

      add_services(supplier, service_codes, jurisdiction, column)
    end
  end

  def add_services(supplier, service_codes, jurisdiction, column)
    supplier_framework_lots_data = supplier[:supplier_frameworks][0][:supplier_framework_lots_data]

    column[2..].each_with_index do |value, index|
      next unless value.to_s.downcase == 'x'

      next if service_codes[index].nil?

      lot_number, service_number = service_codes[index].split('.')

      lot_id = "RM6240.#{lot_number}#{jurisdiction}"
      service_id = "#{lot_id}.#{service_number}"

      supplier_framework_lots_data[lot_id] ||= { services: [], rates: [], jurisdictions: [{ jurisdiction_id: 'GB' }], branches: [] }
      supplier_framework_lots_data[lot_id][:services] << { service_id: }
    end
  end

  def add_rate_cards_to_suppliers(rate_cards_workbook)
    7.times do |sheet_number|
      sheet = rate_cards_workbook.sheet(sheet_number)

      (3..sheet.last_row).each do |row_number|
        row = sheet.row(row_number)
        supplier_duns = row.second.to_i.to_s
        supplier = get_supplier(supplier_duns)
        next unless supplier

        add_rates(supplier, row, sheet_number)
      end
    end
  end

  def add_rates(supplier, row, sheet_number)
    supplier_framework_lots_data = supplier[:supplier_frameworks][0][:supplier_framework_lots_data]
    lot_id = "RM6240.#{LOT_NUMBERS[sheet_number]}"

    row[2..].each.with_index(1) do |rate, position_id|
      supplier_framework_lots_data[lot_id] ||= { services: [], rates: [], jurisdictions: [{ jurisdiction_id: 'GB' }], branches: [] }
      supplier_framework_lots_data[lot_id][:rates] << {
        position_id: "#{lot_id}.#{position_id}",
        rate: convert_rate_to_pence(rate),
        jurisdiction_id: 'GB'
      }
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

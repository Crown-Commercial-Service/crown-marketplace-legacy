class LegalServices::RM6374::Admin::FilesProcessor < FilesProcessor
  private

  def add_suppliers(suppliers_workbook) # rubocop:disable Metrics/MethodLength
    super(
      suppliers_workbook,
      {
        name: 'Supplier Name',
        email: 'Email address',
        telephone_number: 'Phone number',
        website: 'Website URL',
        address: 'Postal address',
        sme: 'Is an SME',
        duns: 'DUNS Number',
        lot_1a_prospectus_link: 'Lot 1a: Prospectus Link',
        lot_1b_prospectus_link: 'Lot 1b: Prospectus Link',
        lot_1c_prospectus_link: 'Lot 1c: Prospectus Link',
        lot_2_prospectus_link: 'Lot 2: Prospectus Link',
        lot_3_prospectus_link: 'Lot 3: Prospectus Link',
        lot_4_prospectus_link: 'Lot 4: Prospectus Link',
        lot_5_prospectus_link: 'Lot 5: Prospectus Link',
        lot_6_prospectus_link: 'Lot 6: Prospectus Link',
        clean: true
      }
    ) do |supplier|
      {
        id: SecureRandom.uuid,
        name: supplier[:name],
        duns_number: supplier[:duns].to_i.to_s,
        sme: ['YES', 'Y'].include?(supplier[:sme].to_s.upcase),
        supplier_frameworks: [
          {
            framework_id: 'RM6374',
            enabled: true,
            supplier_framework_contact_detail: {
              email: supplier[:email],
              telephone_number: supplier[:telephone_number],
              website: supplier[:website],
              additional_details: {
                address: supplier[:address],
                lot_1a_prospectus_link: supplier[:lot_1a_prospectus_link],
                lot_1b_prospectus_link: supplier[:lot_1b_prospectus_link],
                lot_1c_prospectus_link: supplier[:lot_1c_prospectus_link],
                lot_2_prospectus_link: supplier[:lot_2_prospectus_link],
                lot_3_prospectus_link: supplier[:lot_3_prospectus_link],
                lot_4_prospectus_link: supplier[:lot_4_prospectus_link],
                lot_5_prospectus_link: supplier[:lot_5_prospectus_link],
                lot_6_prospectus_link: supplier[:lot_6_prospectus_link]
              }
            },
            supplier_framework_lots_data: Hash.new { |h, k| h[k] = { services: [], rates: [], jurisdictions: [{ jurisdiction_id: 'RM6374.GB' }], branches: [] } },
            supplier_framework_lots: []
          }
        ]
      }
    end
  end

  def add_lot_services_per_supplier(lot_services)
    lot_services.sheets.each do |sheet_name|
      sheet = lot_services.sheet(sheet_name)
      sheet_columns_and_rows = sheet.to_a.transpose

      service_codes = sheet_columns_and_rows[1][2..].map(&:to_s)

      add_service_offerings(sheet_columns_and_rows, service_codes)
    end
  end

  def add_lot_6_services_per_supplier(lot_6_services)
    sheet = lot_6_services.sheet(0)

    sheet_columns_and_rows = sheet.to_a.transpose
    service_codes = sheet_columns_and_rows[1][2..].map(&:to_s)

    add_service_offerings(sheet_columns_and_rows, service_codes)
  end

  def add_service_offerings(sheet_columns_and_rows, service_codes)
    sheet_columns_and_rows[2..].each do |column|
      supplier_duns = column[1].to_i.to_s
      supplier = get_supplier(supplier_duns)
      next unless supplier

      add_services(supplier, service_codes, column)
    end
  end

  def add_services(supplier, service_codes, column)
    supplier_framework_lots_data = supplier[:supplier_frameworks][0][:supplier_framework_lots_data]

    column[2..].each_with_index do |value, index|
      next unless value.to_s.downcase == 'x'
      next if service_codes[index].blank?

      lot_number, service_number = service_codes[index].split('.')
      lot_id = "RM6374.#{lot_number}"
      service_id = "#{lot_id}.#{service_number}"

      services_list = supplier_framework_lots_data[lot_id][:services]
      services_list << { service_id: } unless services_list.any? { |s| s[:service_id] == service_id }
    end
  end

  def add_rate_cards_to_suppliers(rate_cards_workbook)
    rate_cards_workbook.sheets.each_with_index do |sheet_name, sheet_index|
      sheet = rate_cards_workbook.sheet(sheet_name)

      (3..sheet.last_row).each do |row_number|
        row = sheet.row(row_number)
        supplier_duns = row.second.to_i.to_s
        next if supplier_duns.blank? || supplier_duns == '0'

        supplier = get_supplier(supplier_duns)
        next unless supplier

        add_rates(supplier, row, sheet_index)
      end
    end
  end

  def add_rates(supplier, row, sheet_index)
    supplier_framework_lots_data = supplier[:supplier_frameworks][0][:supplier_framework_lots_data]
    lot_name = LOT_NUMBERS[sheet_index]
    lot_id = "RM6374.#{lot_name}"

    max_positions = lot_name == '6' ? 4 : 9

    row[2..].take(max_positions).each.with_index(1) do |rate, position_id|
      next if rate.nil?

      supplier_framework_lots_data[lot_id][:rates] << {
        position_id: "#{lot_id}.#{position_id}",
        rate: convert_rate_to_pence(rate),
        jurisdiction_id: 'RM6374.GB'
      }
    end
  end

  def convert_rate_to_pence(rate)
    rate&.*(100).to_i
  end

  LOT_NUMBERS = ['1a', '1b', '1c', '2', '3', '4', '5', '6'].freeze

  PROCESS_FILES_AND_METHODS = {
    supplier_details_file: :add_suppliers,
    supplier_lot_1a_service_offerings_file: :add_lot_services_per_supplier,
    supplier_lot_1b_service_offerings_file: :add_lot_services_per_supplier,
    supplier_lot_1c_service_offerings_file: :add_lot_services_per_supplier,
    supplier_lot_2_service_offerings_file: :add_lot_services_per_supplier,
    supplier_lot_3_service_offerings_file: :add_lot_services_per_supplier,
    supplier_lot_4_service_offerings_file: :add_lot_services_per_supplier,
    supplier_lot_5_service_offerings_file: :add_lot_services_per_supplier,
    supplier_lot_6_service_offerings_file: :add_lot_6_services_per_supplier,
    supplier_rate_cards_file: :add_rate_cards_to_suppliers
  }.freeze
end

class LegalPanelForGovernment::RM6360::Admin::FilesProcessor < FilesProcessor
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
      lot_4a_prospectus_link: 'Lot 4a: Prospectus Link',
      lot_4b_prospectus_link: 'Lot 4b: Prospectus Link',
      lot_4c_prospectus_link: 'Lot 4c: Prospectus Link',
      lot_5_prospectus_link: 'Lot 5: Prospectus Link',
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
            framework_id: 'RM6360',
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
                lot_4a_prospectus_link: supplier['lot_4a_prospectus_link'],
                lot_4b_prospectus_link: supplier['lot_4b_prospectus_link'],
                lot_4c_prospectus_link: supplier['lot_4c_prospectus_link'],
                lot_5_prospectus_link: supplier['lot_5_prospectus_link'],
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
    LOT_NUMBERS.each.with_index do |lot_number, sheet_number|
      sheet = lot_services.sheet(sheet_number)
      service_ids = sheet.column(2)[2..].map(&:to_s)

      add_service_offerings(sheet, lot_number, service_ids)
    end
  end

  def add_service_offerings(sheet, lot_number, service_ids)
    (3..sheet.last_column).each do |column_number|
      column = sheet.column(column_number)
      supplier_duns = column[1].to_i.to_s
      supplier = get_supplier(supplier_duns)
      next unless supplier

      add_services(supplier, lot_number, service_ids, column)
    end
  end

  def add_services(supplier, lot_number, service_ids, column)
    supplier_framework_lots_data = supplier[:supplier_frameworks][0][:supplier_framework_lots_data]

    lot_id = "RM6360.#{lot_number}"

    column[2..].each_with_index do |value, index|
      next unless value.to_s.downcase == 'x'

      next if service_ids[index].nil?

      service_id = service_ids[index]

      supplier_framework_lots_data[lot_id] ||= { services: [], rates: [], jurisdictions: [{ jurisdiction_id: 'GB' }], branches: [] }
      supplier_framework_lots_data[lot_id][:services] << { service_id: }
    end
  end

  def add_other_lot_rate_cards_to_suppliers(rate_cards_workbook)
    OTHER_LOT_NUMBERS.each.with_index do |lot_number, sheet_number|
      sheet = rate_cards_workbook.sheet(sheet_number)

      (3..sheet.last_row).each do |row_number|
        row = sheet.row(row_number)
        supplier_duns = row.second.to_i.to_s
        supplier = get_supplier(supplier_duns)
        next unless supplier

        add_other_rates(supplier, row, lot_number)
      end
    end
  end

  def add_lot_4a_rate_cards_to_suppliers(rate_cards_workbook)
    add_lot_4_rate_cards_to_suppliers(rate_cards_workbook, '4a')
  end

  def add_lot_4b_rate_cards_to_suppliers(rate_cards_workbook)
    add_lot_4_rate_cards_to_suppliers(rate_cards_workbook, '4b')
  end

  def add_lot_4c_rate_cards_to_suppliers(rate_cards_workbook)
    add_lot_4_rate_cards_to_suppliers(rate_cards_workbook, '4c')
  end

  def add_lot_4_rate_cards_to_suppliers(rate_cards_workbook, lot_number)
    LOT_4_POSITIONS.each.with_index do |position_id, sheet_number|
      sheet = rate_cards_workbook.sheet(sheet_number)

      (3..sheet.last_row).each do |row_number|
        row = sheet.row(row_number)
        supplier_duns = row.second.to_i.to_s
        supplier = get_supplier(supplier_duns)
        next unless supplier

        add_lot_4_rates(supplier, row, position_id, lot_number)
      end
    end

    lot_id = "RM6360.#{lot_number}"

    @supplier_data.each do |supplier|
      supplier_framework_lots_data = supplier[:supplier_frameworks][0][:supplier_framework_lots_data]

      supplier_framework_lots_data[lot_id][:jurisdictions].uniq! if supplier_framework_lots_data[lot_id]
    end
  end

  def add_other_rates(supplier, row, lot_number)
    supplier_framework_lots_data = supplier[:supplier_frameworks][0][:supplier_framework_lots_data]
    lot_id = "RM6360.#{lot_number}"

    supplier_framework_lots_data[lot_id] ||= { services: [], rates: [], jurisdictions: [{ jurisdiction_id: 'GB' }], branches: [] }

    row[2..].each.with_index do |rate, index|
      supplier_framework_lots_data[lot_id][:rates] << {
        position_id: INDEX_TO_POSITION_ID[index],
        rate: convert_rate_to_pence(rate),
        jurisdiction_id: 'GB'
      }
    end
  end

  def add_lot_4_rates(supplier, row, position_id, lot_number)
    supplier_framework_lots_data = supplier[:supplier_frameworks][0][:supplier_framework_lots_data]
    lot_id = "RM6360.#{lot_number}"

    row[2..].each.with_index do |rate, index|
      rate = convert_rate_to_pence(rate)

      next if rate.zero?

      supplier_framework_lots_data[lot_id] ||= { services: [], rates: [], jurisdictions: [], branches: [] }

      jurisdiction_id = JURISDICTION_IDS[index]

      supplier_framework_lots_data[lot_id][:jurisdictions] << {
        jurisdiction_id:
      }
      supplier_framework_lots_data[lot_id][:rates] << {
        position_id:,
        rate:,
        jurisdiction_id:
      }
    end
  end

  def convert_rate_to_pence(rate)
    rate&.*(100).to_i
  end

  LOT_NUMBERS = ['1', '2', '3', '4a', '4b', '4c', '5'].freeze
  OTHER_LOT_NUMBERS = ['1', '2', '3', '5'].freeze
  INDEX_TO_POSITION_ID = [1, 51, 52, 53, 54, 55, 6].freeze
  LOT_4_POSITIONS = [56, 1, 51, 52, 53, 54, 55, 6, 57, 58, 59, 60].freeze
  JURISDICTION_IDS = ['GB', 'AF', 'AX', 'AL', 'DZ', 'AS', 'AD', 'AO', 'AI', 'AQ', 'AG', 'AR', 'AM', 'AW', 'AU', 'AT', 'AZ', 'BS', 'BH', 'BD', 'BB', 'BY', 'BZ', 'BJ', 'BM', 'BT', 'BO', 'BQ', 'BA', 'BW', 'BV', 'BR', 'IO', 'BN', 'BG', 'BF', 'BI', 'CV', 'KH', 'CM', 'KY', 'CF', 'TD', 'CL', 'CN', 'CX', 'CC', 'CO', 'KM', 'CG', 'CD', 'CK', 'CR', 'CI', 'HR', 'CU', 'CW', 'CY', 'CZ', 'DK', 'DJ', 'DM', 'DO', 'EC', 'EG', 'SV', 'GQ', 'ER', 'EE', 'SZ', 'ET', 'FK', 'FO', 'FJ', 'FI', 'GF', 'PF', 'TF', 'GA', 'GM', 'GE', 'GH', 'GI', 'GR', 'GL', 'GD', 'GP', 'GU', 'GT', 'GG', 'GN', 'GW', 'GY', 'HT', 'HM', 'VA', 'HN', 'HK', 'HU', 'IS', 'IN', 'ID', 'IR', 'IQ', 'IM', 'IL', 'IT', 'JM', 'JP', 'JE', 'JO', 'KZ', 'KE', 'KI', 'KP', 'KW', 'KG', 'LA', 'LV', 'LB', 'LS', 'LR', 'LY', 'LI', 'LT', 'LU', 'MO', 'MG', 'MW', 'MY', 'MV', 'ML', 'MT', 'MH', 'MQ', 'MR', 'MU', 'YT', 'MX', 'FM', 'MD', 'MC', 'MN', 'ME', 'MS', 'MA', 'MZ', 'MM', 'NA', 'NR', 'NP', 'NL', 'NC', 'NZ', 'NI', 'NE', 'NG', 'NU', 'NF', 'MK', 'MP', 'NO', 'OM', 'PK', 'PW', 'PS', 'PA', 'PG', 'PY', 'PE', 'PH', 'PN', 'PL', 'PT', 'PR', 'QA', 'RE', 'RO', 'RU', 'RW', 'BL', 'SH', 'KN', 'LC', 'MF', 'PM', 'VC', 'WS', 'SM', 'ST', 'SA', 'SN', 'RS', 'SC', 'SL', 'SX', 'SK', 'SI', 'SB', 'SO', 'ZA', 'GS', 'KR', 'SS', 'ES', 'LK', 'SD', 'SR', 'SJ', 'SE', 'SY', 'TW', 'TJ', 'TZ', 'TH', 'TL', 'TG', 'TK', 'TO', 'TT', 'TN', 'TR', 'TM', 'TC', 'TV', 'AE', 'UG', 'UA', 'UM', 'UY', 'UZ', 'VU', 'VE', 'VN', 'VG', 'VI', 'WF', 'EH', 'YE', 'ZM', 'ZW'].freeze

  PROCESS_FILES_AND_METHODS = {
    supplier_details_file: :add_suppliers,
    supplier_service_offerings_file: :add_lot_services_per_supplier,
    supplier_other_lots_rate_cards_file: :add_other_lot_rate_cards_to_suppliers,
    supplier_lot_4a_rate_cards_file: :add_lot_4a_rate_cards_to_suppliers,
    supplier_lot_4b_rate_cards_file: :add_lot_4b_rate_cards_to_suppliers,
    supplier_lot_4c_rate_cards_file: :add_lot_4c_rate_cards_to_suppliers,
  }.freeze
end

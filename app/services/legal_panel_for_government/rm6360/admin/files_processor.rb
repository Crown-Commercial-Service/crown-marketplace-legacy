class LegalPanelForGovernment::RM6360::Admin::FilesProcessor < FilesProcessor
  def initialize(upload)
    super
    @jurisdiction_name_to_ids = Jurisdiction.non_core.pluck(:mapping_name, :id).to_h
  end

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
      add_rates_from_sheet(rate_cards_workbook.sheet(sheet_number), lot_number)
      remove_duplicate_jurisdictions(lot_number)
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
    add_rates_from_sheet(rate_cards_workbook.sheet(0), lot_number)
    add_non_core_rates_from_sheet(rate_cards_workbook.sheet(1), lot_number)
    remove_duplicate_jurisdictions(lot_number)
  end

  def add_rates_from_sheet(sheet, lot_number)
    (3..sheet.last_row).each do |row_number|
      row = sheet.row(row_number)
      supplier_duns = row.second.to_i.to_s
      supplier = get_supplier(supplier_duns)
      next unless supplier

      add_rates(supplier, row, lot_number)
    end
  end

  def add_non_core_rates_from_sheet(sheet, lot_number)
    (3..sheet.last_row).each do |row_number|
      row = sheet.row(row_number)
      supplier_duns = row.second.to_i.to_s
      supplier = get_supplier(supplier_duns)
      next unless supplier

      jurisdiction_id = @jurisdiction_name_to_ids[row[2]]

      add_rates(supplier, row, lot_number, jurisdiction_id, 3)
    end
  end

  def add_rates(supplier, row, lot_number, jurisdiction_id = 'GB', starting_column = 2)
    supplier_framework_lots_data = supplier[:supplier_frameworks][0][:supplier_framework_lots_data]
    lot_id = "RM6360.#{lot_number}"

    supplier_framework_lots_data[lot_id] ||= { services: [], rates: [], jurisdictions: [], branches: [] }

    row[starting_column..].each.with_index(1) do |rate, index|
      rate = convert_rate_to_pence(rate)

      next if rate.zero?

      position_id = "#{lot_id}.#{index}"

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

  def remove_duplicate_jurisdictions(lot_number)
    lot_id = "RM6360.#{lot_number}"

    @supplier_data.each do |supplier|
      supplier_framework_lots_data = supplier[:supplier_frameworks][0][:supplier_framework_lots_data]

      supplier_framework_lots_data[lot_id][:jurisdictions].uniq! if supplier_framework_lots_data[lot_id]
    end
  end

  def convert_rate_to_pence(rate)
    rate&.*(100).to_i
  end

  LOT_NUMBERS = ['1', '2', '3', '4a', '4b', '4c', '5'].freeze
  OTHER_LOT_NUMBERS = ['1', '2', '3', '5'].freeze

  PROCESS_FILES_AND_METHODS = {
    supplier_details_file: :add_suppliers,
    supplier_service_offerings_file: :add_lot_services_per_supplier,
    supplier_other_lots_rate_cards_file: :add_other_lot_rate_cards_to_suppliers,
    supplier_lot_4a_rate_cards_file: :add_lot_4a_rate_cards_to_suppliers,
    supplier_lot_4b_rate_cards_file: :add_lot_4b_rate_cards_to_suppliers,
    supplier_lot_4c_rate_cards_file: :add_lot_4c_rate_cards_to_suppliers,
  }.freeze
end

class LegalServices::RM6374::Admin::FilesProcessor < FilesProcessor
  private

  def add_suppliers(suppliers_workbook)
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
        # NOTE: Verify if these Lot prospectus links match the RM6374 framework lots.
        lot_1_prospectus_link: 'Lot 1: Prospectus Link',
        lot_2_prospectus_link: 'Lot 2: Prospectus Link',
        lot_3_prospectus_link: 'Lot 3: Prospectus Link',
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
                lot_1_prospectus_link: supplier[:lot_1_prospectus_link],
                lot_2_prospectus_link: supplier[:lot_2_prospectus_link],
                lot_3_prospectus_link: supplier[:lot_3_prospectus_link],
              }
            },
            # NOTE: Updated default jurisdiction_id to RM6374
            supplier_framework_lots_data: Hash.new { |h, k| h[k] = { services: [], rates: [], jurisdictions: [{ jurisdiction_id: 'RM6374.GB' }], branches: [] } },
            supplier_framework_lots: []
          }
        ]
      }
    end
  end

  def add_supplier_geographical_data(geographical_data_workbook)
    # TODO: Implement parsing logic for the geographical data workbook.
    # 
    # Example approach based on other methods:
    # 1. Iterate through sheets/rows.
    # 2. Extract the DUNS number to find the supplier: `supplier = get_supplier(supplier_duns)`
    # 3. Extract the geographical data/regions from the row.
    # 4. Append it to `supplier[:supplier_frameworks][0][:supplier_framework_lots_data][lot_id][:jurisdictions]` or `[:branches]`
  end

  def add_rate_cards_to_suppliers(rate_cards_workbook)
    # NOTE: Ensure the loop count matches the number of sheets in the new RM6374 rate cards file.
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
    lot_id = "RM6374.#{LOT_NUMBERS[sheet_number]}"

    row[2..].each.with_index(1) do |rate, position_id|
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

  # NOTE: Update this array if the lot numbers/structure changed for RM6374.
  LOT_NUMBERS = ['1a', '1b', '1c', '2a', '2b', '2c', '3'].freeze

  PROCESS_FILES_AND_METHODS = {
    supplier_details_file: :add_suppliers,
    supplier_geographical_data_file: :add_supplier_geographical_data,
    supplier_rate_cards_file: :add_rate_cards_to_suppliers
  }.freeze
end
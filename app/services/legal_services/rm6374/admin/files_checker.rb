class LegalServices::RM6374::Admin::FilesChecker
  include FilesImporterHelper

  def initialize(upload)
    @upload = upload
    @errors = []
  end

  def check_files
    CHECK_FILES_AND_METHODS.each do |file, check_method|
      read_spreadsheet(file) do |workbook|
        send(check_method, workbook)
      end
    end

    @errors
  end

  private

  def check_supplier_details_spreadsheet(suppliers_workbook)
    if suppliers_workbook.sheets != ['All Suppliers']
      @errors << { error: 'supplier_details_missing_sheets' }
    elsif suppliers_workbook.sheet(0).row(1) != ['Supplier Name', 'Email address', 'Phone number', 'Website URL', 'Postal address', 'Is an SME', 'DUNS Number', 'Lot 1a: Prospectus Link', 'Lot 1b: Prospectus Link', 'Lot 1c: Prospectus Link', 'Lot 2: Prospectus Link', 'Lot 3: Prospectus Link', 'Lot 4: Prospectus Link', 'Lot 5: Prospectus Link', 'Lot 6: Prospectus Link']
      @errors << { error: 'supplier_details_has_incorrect_headers' }
    elsif suppliers_workbook.sheet(0).last_row == 1
      @errors << { error: 'supplier_details_has_empty_sheets' }
    end
  end

  def check_suppliers_supplier_rate_cards_spreadsheet(rate_cards_workbook)
    check_sheets(rate_cards_workbook, RATE_CARD_SHEETS, 'supplier_rate_cards') do |sheets_with_errors, empty_sheets, index|
      current_sheet = RATE_CARD_SHEETS[index]

      expected_columns = index == 7 ? 6 : 11

      if rate_cards_workbook.sheet(index).last_column != expected_columns
        sheets_with_errors << current_sheet
      elsif rate_cards_workbook.sheet(index).last_row == 2
        empty_sheets << current_sheet
      end
    end
  end

  def check_supplier_lot_1a_service_offerings_spreadsheet(lot_1a_worksheet)
    check_supplier_service_offerings_spreadsheet(lot_1a_worksheet, :'1a')
  end

  def check_supplier_lot_1b_service_offerings_spreadsheet(lot_1b_worksheet)
    check_supplier_service_offerings_spreadsheet(lot_1b_worksheet, :'1b')
  end

  def check_supplier_lot_1c_service_offerings_spreadsheet(lot_1c_worksheet)
    check_supplier_service_offerings_spreadsheet(lot_1c_worksheet, :'1c')
  end

  def check_supplier_lot_2_service_offerings_spreadsheet(lot_2_worksheet)
    check_supplier_service_offerings_spreadsheet(lot_2_worksheet, :'2')
  end

  def check_supplier_lot_3_service_offerings_spreadsheet(lot_3_worksheet)
    check_supplier_service_offerings_spreadsheet(lot_3_worksheet, :'3')
  end

  def check_supplier_lot_4_service_offerings_spreadsheet(lot_4_worksheet)
    check_supplier_service_offerings_spreadsheet(lot_4_worksheet, :'4')
  end

  def check_supplier_lot_5_service_offerings_spreadsheet(lot_5_worksheet)
    check_supplier_service_offerings_spreadsheet(lot_5_worksheet, :'5')
  end

  def check_supplier_lot_6_service_offerings_spreadsheet(lot_6_worksheet)
    check_supplier_service_offerings_spreadsheet(lot_6_worksheet, :'6')
  end

  def check_supplier_service_offerings_spreadsheet(lot_service_offerings_workbook, lot_number)
    worksheet_data = SERVICE_OFFERING_SHEETS[lot_number]
    expected_service_codes = valid_service_codes_from_db(lot_number)

    check_sheets(lot_service_offerings_workbook, worksheet_data[:sheets], "supplier_lot_#{lot_number}_service_offerings") do |sheets_with_errors, empty_sheets, index|
      current_sheet_name = worksheet_data[:sheets][index]
      current_sheet = lot_service_offerings_workbook.sheet(index)

      if current_sheet.last_row != worksheet_data[:last_row] || current_sheet.column(2)[2...worksheet_data[:last_row]].map(&:to_s) != expected_service_codes
        sheets_with_errors << current_sheet_name
      elsif current_sheet.last_column == 2
        empty_sheets << current_sheet_name
      end
    end
  end

  def valid_service_codes_from_db(lot_number)
    codes = Service
            .where('id LIKE ?', "RM6374.#{lot_number}.%")
            .pluck(:number)

    formatted_codes = codes.map do |code|
      code.start_with?("#{lot_number}.") ? code : "#{lot_number}.#{code}"
    end

    formatted_codes.sort_by { |code| code.split('.').last.to_i }
  end

  SERVICE_OFFERING_SHEETS = {
    '1a': {
      sheets: ['England & Wales', 'Scotland', 'Northern Ireland'],
      last_row: 62
    },
    '1b': {
      sheets: ['England & Wales', 'Scotland', 'Northern Ireland'],
      last_row: 62
    },
    '1c': {
      sheets: ['England & Wales', 'Scotland', 'Northern Ireland'],
      last_row: 62
    },
    '2': {
      sheets: ['England & Wales', 'Scotland', 'Northern Ireland'],
      last_row: 71
    },
    '3': {
      sheets: ['England & Wales', 'Scotland', 'Northern Ireland'],
      last_row: 11
    },
    '4': {
      sheets: ['England & Wales', 'Scotland', 'Northern Ireland'],
      last_row: 13
    },
    '5': {
      sheets: ['England & Wales', 'Scotland', 'Northern Ireland'],
      last_row: 25
    },
    '6': {
      sheets: ['All regions'],
      last_row: 4
    },
  }.freeze

  RATE_CARD_SHEETS = ['1a', '1b', '1c', '2', '3', '4', '5', '6'].freeze

  CHECK_FILES_AND_METHODS = {
    supplier_details_file: :check_supplier_details_spreadsheet,
    supplier_rate_cards_file: :check_suppliers_supplier_rate_cards_spreadsheet,
    supplier_lot_1a_service_offerings_file: :check_supplier_lot_1a_service_offerings_spreadsheet,
    supplier_lot_1b_service_offerings_file: :check_supplier_lot_1b_service_offerings_spreadsheet,
    supplier_lot_1c_service_offerings_file: :check_supplier_lot_1c_service_offerings_spreadsheet,
    supplier_lot_2_service_offerings_file: :check_supplier_lot_2_service_offerings_spreadsheet,
    supplier_lot_3_service_offerings_file: :check_supplier_lot_3_service_offerings_spreadsheet,
    supplier_lot_4_service_offerings_file: :check_supplier_lot_4_service_offerings_spreadsheet,
    supplier_lot_5_service_offerings_file: :check_supplier_lot_5_service_offerings_spreadsheet,
    supplier_lot_6_service_offerings_file: :check_supplier_lot_6_service_offerings_spreadsheet
  }.freeze
end

class LegalServices::RM6240::Admin::FilesChecker
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
    elsif suppliers_workbook.sheet(0).row(1) != ['Supplier Name', 'Email address', 'Phone number', 'Website URL', 'Postal address', 'Is an SME', 'DUNS Number', 'Lot 1: Prospectus Link', 'Lot 2: Prospectus Link', 'Lot 3: Prospectus Link']
      @errors << { error: 'supplier_details_has_incorrect_headers' }
    elsif suppliers_workbook.sheet(0).last_row == 1
      @errors << { error: 'supplier_details_has_empty_sheets' }
    end
  end

  def check_suppliers_supplier_rate_cards_spreadsheet(rate_cards_workbook)
    check_sheets(rate_cards_workbook, RATE_CARD_SHEETS, 'supplier_rate_cards') do |sheets_with_errors, empty_sheets, index|
      current_sheet = RATE_CARD_SHEETS[index]

      if rate_cards_workbook.sheet(index).last_column != 9
        sheets_with_errors << current_sheet
      elsif rate_cards_workbook.sheet(index).last_row == 2
        empty_sheets << current_sheet
      end
    end
  end

  def check_supplier_lot_1_service_offerings_spreadsheet(lot_1_worksheet)
    check_supplier_lot_service_offerings_spreadsheet(lot_1_worksheet, :'1')
  end

  def check_supplier_lot_2_service_offerings_spreadsheet(lot_2_worksheet)
    check_supplier_lot_service_offerings_spreadsheet(lot_2_worksheet, :'2')
  end

  def check_supplier_lot_3_service_offerings_spreadsheet(lot_3_worksheet)
    check_supplier_lot_service_offerings_spreadsheet(lot_3_worksheet, :'3')
  end

  def check_supplier_lot_service_offerings_spreadsheet(worksheet, lot_number)
    worksheet_data = SERVICE_OFFERING_SHEETS[lot_number]

    check_sheets(worksheet, worksheet_data[:sheets], "supplier_lot_#{lot_number}_service_offerings") do |sheets_with_errors, empty_sheets, index|
      current_sheet_name = worksheet_data[:sheets][index]
      current_sheet = worksheet.sheet(index)

      if current_sheet.last_row != worksheet_data[:last_row] || current_sheet.column(2)[2..].map(&:to_s) != (1..worksheet_data[:last_row] - 2).map { |service_number| "#{lot_number}.#{service_number}" }
        sheets_with_errors << current_sheet_name
      elsif current_sheet.last_column == 2
        empty_sheets << current_sheet_name
      end
    end
  end

  RATE_CARD_SHEETS = ['Lot 1a - England & Wales', 'Lot 1b - Scotland', 'Lot 1c - Northern Ireland', 'Lot 2a - England & Wales', 'Lot 2b - Scotland', 'Lot 2c - Northern Ireland', 'Lot 3'].freeze

  SERVICE_OFFERING_SHEETS = {
    '1': {
      sheets: ['Lot 1a - England & Wales', 'Lot 1b - Scotland', 'Lot 1c - Northern Ireland'],
      last_row: 42
    },
    '2': {
      sheets: ['Lot 2a - England & Wales', 'Lot 2b - Scotland', 'Lot 2c - Northern Ireland'],
      last_row: 17
    },
    '3': {
      sheets: ['All regions'],
      last_row: 3
    }
  }.freeze

  CHECK_FILES_AND_METHODS = {
    supplier_details_file: :check_supplier_details_spreadsheet,
    supplier_rate_cards_file: :check_suppliers_supplier_rate_cards_spreadsheet,
    supplier_lot_1_service_offerings_file: :check_supplier_lot_1_service_offerings_spreadsheet,
    supplier_lot_2_service_offerings_file: :check_supplier_lot_2_service_offerings_spreadsheet,
    supplier_lot_3_service_offerings_file: :check_supplier_lot_3_service_offerings_spreadsheet
  }.freeze
end

class LegalServices::RM3788::Admin::FilesChecker
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
    elsif suppliers_workbook.sheet(0).row(1) != ['Supplier Name', 'Email address', 'Phone number', 'Website URL', 'Postal address', 'Is an SME', 'DUNS Number', 'Lot 1: Prospectus Link', 'Lot 2: Prospectus Link', 'Lot 3: Prospectus Link', 'Lot 4: Prospectus Link', 'About the supplier']
      @errors << { error: 'supplier_details_has_incorrect_headers' }
    elsif suppliers_workbook.sheet(0).last_row == 1
      @errors << { error: 'supplier_details_has_empty_sheets' }
    end
  end

  def check_suppliers_supplier_rate_cards_spreadsheet(rate_cards_workbook)
    check_sheets(rate_cards_workbook, map_sheets(RATE_CARD_SHEET_INDEX_TO_SHEET), 'supplier_rate_cards') do |sheets_with_errors, empty_sheets, index|
      if rate_cards_workbook.sheet(index).last_column != RATE_CARD_SHEET_INDEX_TO_SHEET[index][:columns]
        sheets_with_errors << index_to_service_code(index, RATE_CARD_SHEET_INDEX_TO_SHEET)
      elsif rate_cards_workbook.sheet(index).last_row == 2
        empty_sheets << index_to_service_code(index, RATE_CARD_SHEET_INDEX_TO_SHEET)
      end
    end
  end

  def check_supplier_lot_1_service_offerings_spreadsheet(lot_1_worksheet)
    check_supplier_service_offerings_spreadsheet(lot_1_worksheet, :'1')
  end

  def check_supplier_lot_2_service_offerings_spreadsheet(lot_2_worksheet)
    check_supplier_service_offerings_spreadsheet(lot_2_worksheet, :'2')
  end

  def check_supplier_service_offerings_spreadsheet(worksheet, lot_number)
    sheet_information = SERVICE_OFFERING_SHEETS_INFORMATION[lot_number]

    check_sheets(worksheet, map_sheets(sheet_information[:sheets]), "supplier_lot_#{lot_number}_service_offerings") do |sheets_with_errors, empty_sheets, index|
      if worksheet.sheet(index).last_row != sheet_information[:last_row]
        sheets_with_errors << index_to_service_code(index, sheet_information[:sheets])
      elsif worksheet.sheet(index).last_column == 1
        empty_sheets << index_to_service_code(index, sheet_information[:sheets])
      end
    end
  end

  def check_supplier_lot_3_service_offerings_spreadsheet(lot_3_worksheet)
    check_lot_3_or_4(lot_3_worksheet, 3)
  end

  def check_supplier_lot_4_service_offerings_spreadsheet(lot_4_worksheet)
    check_lot_3_or_4(lot_4_worksheet, 4)
  end

  def index_to_service_code(index, maping)
    maping[index][:sheet]
  end

  def map_sheets(sheet_mapping)
    sheet_mapping.map { |sheet| sheet[:sheet] }
  end

  def check_lot_3_or_4(worksheet, lot)
    if worksheet.sheets != ['All regions']
      @errors << { error: "supplier_lot_#{lot}_service_offerings_missing_sheets" }
    elsif !(worksheet.sheet(0).last_row == 2 && worksheet.sheet(0).row(2).first.to_s.include?("[WPSLS.#{lot}.1]"))
      @errors << { error: "supplier_lot_#{lot}_service_offerings_has_incorrect_headers" }
    elsif worksheet.sheet(0).last_column == 1
      @errors << { error: "supplier_lot_#{lot}_service_offerings_has_empty_sheets" }
    end
  end

  RATE_CARD_SHEET_INDEX_TO_SHEET = [{ sheet: 'Lot 1', columns: 13 }, { sheet: 'Lot 2a - England & Wales', columns: 16 }, { sheet: 'Lot 2b - Scotland', columns: 16 }, { sheet: 'Lot 2c - Northern Ireland', columns: 16 }, { sheet: 'Lot 3', columns: 16 }, { sheet: 'Lot 4', columns: 16 }].freeze
  SERVICE_OFFERING_SHEETS_INFORMATION = {
    '1': {
      sheets: [{ sheet: 'Full UK Coverage' }, { sheet: 'North East England (NUTS C)' }, { sheet: 'North West England (NUTS D)' }, { sheet: 'Yorkshire & Humberside (NUTS E)' }, { sheet: 'East Midlands (NUTS F)' }, { sheet: 'West Midlands (NUTS G)' }, { sheet: 'East of England (NUTS H)' }, { sheet: 'Greater London (NUTS I)' }, { sheet: 'South East England (NUTS J)' }, { sheet: 'South West England (NUTS K)' }, { sheet: 'Wales (NUTS L)' }, { sheet: 'Scotland (NUTS M)' }, { sheet: 'Northern Ireland (NUTS N)' }],
      last_row: 15
    },
    '2': {
      sheets: [{ sheet: 'Lot 2a - England & Wales' }, { sheet: 'Lot 2b - Scotland' }, { sheet: 'Lot 2c - Northern Ireland' }],
      last_row: 36
    }
  }.freeze

  CHECK_FILES_AND_METHODS = {
    supplier_details_file: :check_supplier_details_spreadsheet,
    supplier_rate_cards_file: :check_suppliers_supplier_rate_cards_spreadsheet,
    supplier_lot_1_service_offerings_file: :check_supplier_lot_1_service_offerings_spreadsheet,
    supplier_lot_2_service_offerings_file: :check_supplier_lot_2_service_offerings_spreadsheet,
    supplier_lot_3_service_offerings_file: :check_supplier_lot_3_service_offerings_spreadsheet,
    supplier_lot_4_service_offerings_file: :check_supplier_lot_4_service_offerings_spreadsheet,
  }.freeze
end

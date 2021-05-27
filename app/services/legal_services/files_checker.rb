class LegalServices::FilesChecker
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
    @errors << { error: 'supplier_details_missing_sheets' } if suppliers_workbook.sheets != ['All Suppliers']
    @errors << { error: 'supplier_details_headers_incorrect' } if suppliers_workbook.sheet(0).row(1) != ['Supplier Name', 'Email address', 'Phone number', 'Website URL', 'Postal address', 'Is an SME', 'DUNS Number', 'Lot 1: Prospectus Link', 'Lot 2: Prospectus Link', 'Lot 3: Prospectus Link', 'Lot 4: Prospectus Link', 'About the supplier']
  end

  def check_suppliers_supplier_rate_cards_spreadsheet(rate_cards_workbook)
    if rate_cards_workbook.sheets != ['Lot 1', 'Lot 2a - England & Wales', 'Lot 2b - Scotland', 'Lot 2c - Northern Ireland', 'Lot 3', 'Lot 4']
      @errors << { error: 'supplier_rate_cards_missing_sheets' }
    else
      sheets_with_errors = []

      6.times do |index|
        sheets_with_errors << index_to_service_code(index, RATE_CARD_SHEET_INDEX_TO_SHEET) if rate_cards_workbook.sheet(index).last_column != RATE_CARD_SHEET_INDEX_TO_SHEET[index][:columns]
      end

      @errors << { error: 'supplier_rate_cards_missing_column', details: sheets_with_errors } if sheets_with_errors.any?
    end
  end

  def check_supplier_lot_1_service_offerings_spreadsheet(lot_1_worksheet)
    if lot_1_worksheet.sheets != ['Full UK Coverage', 'North East England (NUTS C)', 'North West England (NUTS D)', 'Yorkshire & Humberside (NUTS E)', 'East Midlands (NUTS F)', 'West Midlands (NUTS G)', 'East of England (NUTS H)', 'Greater London (NUTS I)', 'South East England (NUTS J)', 'South West England (NUTS K)', 'Wales (NUTS L)', 'Scotland (NUTS M)', 'Northern Ireland (NUTS N)']
      @errors << { error: 'supplier_lot_1_service_offerings_missing_sheets' }
    else
      sheets_with_errors = []

      13.times do |index|
        sheets_with_errors << index_to_service_code(index, LOT_1_SHEET_INDEX_TO_SERVICE_SHEET) if lot_1_worksheet.sheet(index).last_row != 15
      end

      @errors << { error: 'supplier_lot_1_service_offerings_missing_row', details: sheets_with_errors } if sheets_with_errors.any?
    end
  end

  def check_supplier_lot_2_service_offerings_spreadsheet(lot_2_worksheet)
    if lot_2_worksheet.sheets != ['Lot 2a - England & Wales', 'Lot 2b - Scotland', 'Lot 2c - Northern Ireland']
      @errors << { error: 'supplier_lot_2_service_offerings_missing_sheets' }
    else
      sheets_with_errors = []

      3.times do |index|
        sheets_with_errors << index_to_service_code(index, LOT_2_SHEET_INDEX_TO_SERVICE_SHEET) if lot_2_worksheet.sheet(index).last_row != 36
      end

      @errors << { error: 'supplier_lot_2_service_offerings_missing_row', details: sheets_with_errors } if sheets_with_errors.any?
    end
  end

  def check_supplier_lot_3_service_offerings_spreadsheet(lot_3_worksheet)
    if lot_3_worksheet.sheets != ['All regions']
      @errors << { error: 'supplier_lot_3_service_offerings_missing_sheets' }
    elsif lot_3_worksheet.sheet(0).last_row != 2
      @errors << { error: 'supplier_lot_3_service_offerings_missing_row' }
    end
  end

  def check_supplier_lot_4_service_offerings_spreadsheet(lot_4_worksheet)
    if lot_4_worksheet.sheets != ['All regions']
      @errors << { error: 'supplier_lot_4_service_offerings_missing_sheets' }
    elsif lot_4_worksheet.sheet(0).last_row != 2
      @errors << { error: 'supplier_lot_4_service_offerings_missing_row' }
    end
  end

  def index_to_service_code(index, maping)
    maping[index][:sheet]
  end

  RATE_CARD_SHEET_INDEX_TO_SHEET = [{ sheet: '1', columns: 13 }, { sheet: '2a', columns: 16 }, { sheet: '2b', columns: 16 }, { sheet: '2c', columns: 16 }, { sheet: '3', columns: 16 }, { sheet: '4', columns: 16 }].freeze
  LOT_1_SHEET_INDEX_TO_SERVICE_SHEET = [{ sheet: 'full_uk' }, { sheet: 'nuts_c' }, { sheet: 'nuts_d' }, { sheet: 'nuts_e' }, { sheet: 'nuts_f' }, { sheet: 'nuts_g' }, { sheet: 'nuts_h' }, { sheet: 'nuts_i' }, { sheet: 'nuts_j' }, { sheet: 'nuts_k' }, { sheet: 'nuts_l' }, { sheet: 'nuts_m' }, { sheet: 'nuts_n' }].freeze
  LOT_2_SHEET_INDEX_TO_SERVICE_SHEET = [{ sheet: 'a' }, { sheet: 'b' }, { sheet: 'c' }].freeze

  CHECK_FILES_AND_METHODS = {
    supplier_details_file: :check_supplier_details_spreadsheet,
    supplier_rate_cards_file: :check_suppliers_supplier_rate_cards_spreadsheet,
    supplier_lot_1_service_offerings_file: :check_supplier_lot_1_service_offerings_spreadsheet,
    supplier_lot_2_service_offerings_file: :check_supplier_lot_2_service_offerings_spreadsheet,
    supplier_lot_3_service_offerings_file: :check_supplier_lot_3_service_offerings_spreadsheet,
    supplier_lot_4_service_offerings_file: :check_supplier_lot_4_service_offerings_spreadsheet,
  }.freeze
end

class LegalPanelForGovernment::RM6360::Admin::FilesChecker
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
    elsif suppliers_workbook.sheet(0).row(1) != ['Supplier Name', 'Email address', 'Phone number', 'Website URL', 'Postal address', 'Is an SME', 'DUNS Number', 'Lot 1: Prospectus Link', 'Lot 2: Prospectus Link', 'Lot 3: Prospectus Link', 'Lot 4a: Prospectus Link', 'Lot 4b: Prospectus Link', 'Lot 4c: Prospectus Link', 'Lot 5: Prospectus Link']
      @errors << { error: 'supplier_details_has_incorrect_headers' }
    elsif suppliers_workbook.sheet(0).last_row == 1
      @errors << { error: 'supplier_details_has_empty_sheets' }
    end
  end

  def check_supplier_lot_service_offerings_spreadsheet(service_offerings_workbook)
    check_sheets(service_offerings_workbook, SERVICE_OFFERING_SHEETS[:sheets], 'supplier_service_offerings') do |sheets_with_errors, empty_sheets, index|
      current_sheet_name = SERVICE_OFFERING_SHEETS[:sheets][index]
      current_sheet = service_offerings_workbook.sheet(index)
      last_row = SERVICE_OFFERING_SHEETS[:last_rows][index]
      lot_id = "RM6360.#{current_sheet_name.split[1]}"

      if current_sheet.last_row != last_row || current_sheet.column(2)[2..].map(&:to_s) != (1..(last_row - 2)).map { |service_number| "#{lot_id}.#{service_number}" }
        sheets_with_errors << current_sheet_name
      elsif current_sheet.last_column == 2
        empty_sheets << current_sheet_name
      end
    end
  end

  def check_suppliers_other_lots_rate_cards_file(rate_cards_workbook)
    check_sheets(rate_cards_workbook, OTHER_LOTS_RATE_CARD_SHEETS, 'supplier_other_lots_rate_cards') do |sheets_with_errors, empty_sheets, index|
      current_sheet = OTHER_LOTS_RATE_CARD_SHEETS[index]

      if rate_cards_workbook.sheet(index).last_column != 9
        sheets_with_errors << current_sheet
      elsif rate_cards_workbook.sheet(index).last_row == 2
        empty_sheets << current_sheet
      end
    end
  end

  def check_suppliers_lot_4a_rate_cards_file(rate_cards_workbook)
    check_suppliers_lot_4_rate_cards_file(rate_cards_workbook, '4a')
  end

  def check_suppliers_lot_4b_rate_cards_file(rate_cards_workbook)
    check_suppliers_lot_4_rate_cards_file(rate_cards_workbook, '4b')
  end

  def check_suppliers_lot_4c_rate_cards_file(rate_cards_workbook)
    check_suppliers_lot_4_rate_cards_file(rate_cards_workbook, '4c')
  end

  def check_suppliers_lot_4_rate_cards_file(rate_cards_workbook, lot_number)
    check_sheets(rate_cards_workbook, LOT_4_RATE_CARD_SHEETS, "supplier_lot_#{lot_number}_rate_cards") do |sheets_with_errors, empty_sheets, index|
      current_sheet = LOT_4_RATE_CARD_SHEETS[index]

      if rate_cards_workbook.sheet(index).last_column != 243
        sheets_with_errors << current_sheet
      elsif rate_cards_workbook.sheet(index).last_row == 2
        empty_sheets << current_sheet
      end
    end
  end

  OTHER_LOTS_RATE_CARD_SHEETS = ['Lot 1', 'Lot 2', 'Lot 3', 'Lot 5'].freeze
  LOT_4_RATE_CARD_SHEETS = ['Senior Counsel', 'Partner', 'Legal Director', 'Senior Solicitor', 'Solicitor', 'NQ Solicitor', 'Trainee', 'Paralegal', 'Senior Analyst', 'Analyst', 'Senior Modeller', 'Modeller'].freeze

  SERVICE_OFFERING_SHEETS = {
    sheets: ['Lot 1', 'Lot 2', 'Lot 3', 'Lot 4a', 'Lot 4b', 'Lot 4c', 'Lot 5'],
    last_rows: [50, 61, 25, 12, 11, 7, 22]
  }.freeze

  CHECK_FILES_AND_METHODS = {
    supplier_details_file: :check_supplier_details_spreadsheet,
    supplier_service_offerings_file: :check_supplier_lot_service_offerings_spreadsheet,
    supplier_other_lots_rate_cards_file: :check_suppliers_other_lots_rate_cards_file,
    supplier_lot_4a_rate_cards_file: :check_suppliers_lot_4a_rate_cards_file,
    supplier_lot_4b_rate_cards_file: :check_suppliers_lot_4b_rate_cards_file,
    supplier_lot_4c_rate_cards_file: :check_suppliers_lot_4c_rate_cards_file,
  }.freeze
end

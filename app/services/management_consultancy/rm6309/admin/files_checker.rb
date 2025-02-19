class ManagementConsultancy::RM6309::Admin::FilesChecker
  include FilesImporterHelper

  def initialize(upload)
    @upload = upload
    @errors = []
  end

  def check_files
    check_files_and_methods.each do |file, check_method|
      read_spreadsheet(file) do |workbook|
        send(check_method, workbook)
      end
    end

    @errors
  end

  private

  def check_supplier_details_spreadsheet(suppliers_workbook)
    check_sheets(suppliers_workbook, supplier_details_sheets, 'supplier_details') do |sheets_with_errors, empty_sheets, index|
      framework = "MCF#{index_to_framework[index]}"

      if suppliers_workbook.sheet(index).row(1) != ['Supplier name', 'Email address', 'Phone number', 'Website URL', 'Postal address', 'Is an SME?', 'DUNS Number']
        sheets_with_errors << framework
      elsif suppliers_workbook.sheet(index).last_row == 1
        empty_sheets << framework
      end
    end
  end

  def check_supplier_rate_cards_spreadsheet(rate_cards_workbook)
    check_sheets(rate_cards_workbook, all_sheets, 'supplier_rate_cards') do |sheets_with_errors, empty_sheets, index|
      service_code = index_to_service_code(index)

      if rate_cards_workbook.sheet(index).last_column != 16
        sheets_with_errors << service_code
      elsif rate_cards_workbook.sheet(index).last_row == 1
        empty_sheets << service_code
      end
    end
  end

  def check_supplier_service_offerings_spreadsheet(service_offerings_workbook)
    check_sheets(service_offerings_workbook, all_sheets, 'supplier_service_offerings') do |sheets_with_errors, empty_sheets, index|
      if service_offerings_workbook.sheet(index).last_row != sheet_index_to_service_code[index][:rows]
        sheets_with_errors << index_to_service_code(index)
      elsif service_offerings_workbook.sheet(index).last_column == 1
        empty_sheets << index_to_service_code(index)
      end
    end
  end

  def index_to_service_code(index)
    "MCF#{sheet_index_to_service_code[index][:mcf]} Lot #{sheet_index_to_service_code[index][:code]}"
  end

  def supplier_details_sheets
    self.class::SUPPLIER_DETAILS_SHEETS
  end

  def index_to_framework
    self.class::INDEX_TO_FRAMEWORK
  end

  def all_sheets
    self.class::ALL_SHEETS
  end

  def sheet_index_to_service_code
    self.class::SHEET_INDEX_TO_SERVICE_CODE
  end

  def check_files_and_methods
    self.class::CHECK_FILES_AND_METHODS
  end

  SUPPLIER_DETAILS_SHEETS = ['MCF4'].freeze
  INDEX_TO_FRAMEWORK = [4].freeze
  ALL_SHEETS = ['MCF4 Lot 1', 'MCF4 Lot 2', 'MCF4 Lot 3', 'MCF4 Lot 4', 'MCF4 Lot 5', 'MCF4 Lot 6', 'MCF4 Lot 7', 'MCF4 Lot 8', 'MCF4 Lot 9', 'MCF4 Lot 10'].freeze
  SHEET_INDEX_TO_SERVICE_CODE = [{ mcf: 4, code: 1, rows: 15 }, { mcf: 4, code: 2, rows: 13 }, { mcf: 4, code: 3, rows: 15 }, { mcf: 4, code: 4, rows: 21 }, { mcf: 4, code: 5, rows: 10 }, { mcf: 4, code: 6, rows: 13 }, { mcf: 4, code: 7, rows: 21 }, { mcf: 4, code: 8, rows: 14 }, { mcf: 4, code: 9, rows: 19 }, { mcf: 4, code: 10, rows: 4 }].freeze

  CHECK_FILES_AND_METHODS = {
    supplier_details_file: :check_supplier_details_spreadsheet,
    supplier_rate_cards_file: :check_supplier_rate_cards_spreadsheet,
    supplier_service_offerings_file: :check_supplier_service_offerings_spreadsheet
  }.freeze
end

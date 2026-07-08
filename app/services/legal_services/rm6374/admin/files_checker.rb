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
    # NOTE: Verify if these headers are identical in the new framework, as prospectus links often change between frameworks.
    elsif suppliers_workbook.sheet(0).row(1) != ['Supplier Name', 'Email address', 'Phone number', 'Website URL', 'Postal address', 'Is an SME', 'DUNS Number', 'Lot 1: Prospectus Link', 'Lot 2: Prospectus Link', 'Lot 3: Prospectus Link']
      @errors << { error: 'supplier_details_has_incorrect_headers' }
    elsif suppliers_workbook.sheet(0).last_row == 1
      @errors << { error: 'supplier_details_has_empty_sheets' }
    end
  end

  def check_supplier_geographical_data_spreadsheet(geographical_data_workbook)
    check_sheets(geographical_data_workbook, GEOGRAPHICAL_DATA_SHEETS, 'supplier_geographical_data') do |sheets_with_errors, empty_sheets, index|
      current_sheet = GEOGRAPHICAL_DATA_SHEETS[index]

      # NOTE: Update the expected last_column and last_row conditions based on the actual Geographical Data spreadsheet template.
      if geographical_data_workbook.sheet(index).last_column != GEOGRAPHICAL_DATA_EXPECTED_COLUMNS
        sheets_with_errors << current_sheet
      elsif geographical_data_workbook.sheet(index).last_row <= 1
        empty_sheets << current_sheet
      end
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

  # NOTE: Verify if the lot structure/sheet names are still the same for the new framework.
  RATE_CARD_SHEETS = ['Lot 1a - England & Wales', 'Lot 1b - Scotland', 'Lot 1c - Northern Ireland', 'Lot 2a - England & Wales', 'Lot 2b - Scotland', 'Lot 2c - Northern Ireland', 'Lot 3'].freeze

  # TODO: Define the sheet names expected in the new geographical data file.
  GEOGRAPHICAL_DATA_SHEETS = ['Sheet 1', 'Sheet 2'].freeze
  
  # TODO: Set the correct number of expected columns for the geographical data file.
  GEOGRAPHICAL_DATA_EXPECTED_COLUMNS = 5

  CHECK_FILES_AND_METHODS = {
    supplier_details_file: :check_supplier_details_spreadsheet,
    supplier_geographical_data_file: :check_supplier_geographical_data_spreadsheet,
    supplier_rate_cards_file: :check_suppliers_supplier_rate_cards_spreadsheet
  }.freeze
end
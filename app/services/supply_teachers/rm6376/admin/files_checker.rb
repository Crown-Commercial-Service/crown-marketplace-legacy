class SupplyTeachers::RM6376::Admin::FilesChecker
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
    elsif suppliers_workbook.sheet(0).row(1) != ['Supplier Name', 'Supplier Trading Name', 'Supplier Identifier', 'Managed service provider contact name', 'Managed service provider contact email', 'Managed service provider contact telephone', 'Lot 1', 'Lot 2']
      @errors << { error: 'supplier_details_has_incorrect_headers' }
    elsif suppliers_workbook.sheet(0).last_row == 1
      @errors << { error: 'supplier_details_has_empty_sheets' }
    end
  end

  def check_supplier_geographical_data_spreadsheet(supplier_geographical_data_workbook)
    if supplier_geographical_data_workbook.sheets != ['Branch details']
      @errors << { error: 'supplier_geographical_data_missing_sheets' }
    elsif supplier_geographical_data_workbook.sheet(0).row(1) != ['Supplier Name', 'Supplier Identifier', 'Branch Name/No.', 'Branch Contact name', 'Address 1', 'Address 2', 'Town', 'County', 'Post Code', 'Branch Contact Name Email Address', 'Branch Telephone Number', 'Region']
      @errors << { error: 'supplier_geographical_data_has_incorrect_headers' }
    elsif supplier_geographical_data_workbook.sheet(0).last_row == 1
      @errors << { error: 'supplier_geographical_data_has_empty_sheets' }
    end
  end

  def check_supplier_rate_cards_file(rate_cards_workbook)
    check_sheets(rate_cards_workbook, RATE_CARD_SHEETS, 'supplier_rate_cards') do |sheets_with_errors, empty_sheets, index|
      current_sheet = RATE_CARD_SHEETS[index]

      if rate_cards_workbook.sheet(index).last_column != 13
        sheets_with_errors << current_sheet
      elsif rate_cards_workbook.sheet(index).last_row == 2
        empty_sheets << current_sheet
      end
    end
  end

  RATE_CARD_SHEETS = ['Lot 1', 'Lot 2'].freeze

  CHECK_FILES_AND_METHODS = {
    supplier_details_file: :check_supplier_details_spreadsheet,
    supplier_geographical_data_file: :check_supplier_geographical_data_spreadsheet,
    supplier_rate_cards_file: :check_supplier_rate_cards_file,
  }.freeze
end

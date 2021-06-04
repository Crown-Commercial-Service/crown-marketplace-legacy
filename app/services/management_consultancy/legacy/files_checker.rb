class ManagementConsultancy::Legacy::FilesChecker < ManagementConsultancy::FilesChecker
  private

  def check_supplier_regional_offerings_spreadsheet(regional_offerings_workbook)
    if regional_offerings_workbook.sheets != supplier_regional_offerings_sheets
      @errors << { error: 'supplier_regional_offerings_missing_sheets' }
    else
      sheets_with_errors = []

      number_of_sheets(regional_offerings_workbook).times do |index|
        sheets_with_errors << index_to_service_code(index) if regional_offerings_workbook.sheet(index).row(1)[1..].map { |region_name| extract_region_code(region_name) } != ['UKC', 'UKC1', 'UKC2', 'UKD', 'UKD1', 'UKD3', 'UKD4', 'UKD6', 'UKD7', 'UKE', 'UKE1', 'UKE2', 'UKE3', 'UKE4', 'UKF', 'UKF1', 'UKF2', 'UKF3', 'UKG', 'UKG1', 'UKG2', 'UKG3', 'UKH', 'UKH1', 'UKH2', 'UKH3', 'UKI', 'UKI3', 'UKI4', 'UKI5', 'UKI6', 'UKI7', 'UKJ', 'UKJ1', 'UKJ2', 'UKJ3', 'UKJ4', 'UKK', 'UKK1', 'UKK2', 'UKK3', 'UKK4', 'UKL', 'UKL1', 'UKL2', 'UKM', 'UKM2', 'UKM3', 'UKM5', 'UKM6', 'UKN0']
      end

      @errors << { error: 'supplier_regional_offerings_headers_incorrect', details: sheets_with_errors } if sheets_with_errors.any?
    end
  end

  SUPPLIER_DETAILS_SHEETS = ['MCF', 'MCF2', 'MCF3'].freeze
  INDEX_TO_FRAMEWORK = [nil, 2, 3].freeze
  ALL_SHEETS = ['MCF Lot 2', 'MCF Lot 3', 'MCF Lot 4', 'MCF Lot 5', 'MCF Lot 6', 'MCF Lot 7', 'MCF Lot 8', 'MCF2 Lot 1', 'MCF2 Lot 2', 'MCF2 Lot 3', 'MCF2 Lot 4', 'MCF3 Lot 1', 'MCF3 Lot 2', 'MCF3 Lot 3', 'MCF3 Lot 4', 'MCF3 Lot 5', 'MCF3 Lot 6', 'MCF3 Lot 7', 'MCF3 Lot 8', 'MCF3 Lot 9'].freeze
  SUPPLIER_REGIONAL_OFFERINGS_SHEETS = ['MCF Lot 2', 'MCF Lot 3', 'MCF Lot 4', 'MCF Lot 5', 'MCF Lot 6', 'MCF Lot 7', 'MCF Lot 8', 'MCF2 Lot 1', 'MCF2 Lot 2', 'MCF2 Lot 3', 'MCF2 Lot 4'].freeze
  SHEET_INDEX_TO_SERVICE_CODE = [{ code: 2, rows: 35 }, { code: 3, rows: 19 }, { code: 4, rows: 12 }, { code: 5, rows: 23 }, { code: 6, rows: 31 }, { code: 7, rows: 28 }, { code: 8, rows: 20 },
                                 { mcf: 2, code: 1, rows: 70 }, { mcf: 2, code: 2, rows: 53 }, { mcf: 2, code: 3, rows: 28 }, { mcf: 2, code: 4, rows: 38 },
                                 { mcf: 3, code: 1, rows: 15 }, { mcf: 3, code: 2, rows: 10 }, { mcf: 3, code: 3, rows: 14 }, { mcf: 3, code: 4, rows: 25 }, { mcf: 3, code: 5, rows: 11 }, { mcf: 3, code: 6, rows: 14 }, { mcf: 3, code: 7, rows: 22 }, { mcf: 3, code: 8, rows: 9 }, { mcf: 3, code: 9, rows: 20 }].freeze
  CHECK_FILES_AND_METHODS = {
    supplier_details_file: :check_supplier_details_spreadsheet,
    supplier_rate_cards_file: :check_supplier_rate_cards_spreadsheet,
    supplier_regional_offerings_file: :check_supplier_regional_offerings_spreadsheet,
    supplier_service_offerings_file: :check_supplier_service_offerings_spreadsheet
  }.freeze
end

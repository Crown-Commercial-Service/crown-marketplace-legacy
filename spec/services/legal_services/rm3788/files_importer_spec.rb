require 'rails_helper'

RSpec.describe LegalServices::RM3788::FilesImporter do
  let(:upload) do
    create(:legal_services_rm3788_admin_upload, aasm_state: 'in_progress') do |admin_upload|
      admin_upload.supplier_details_file.attach(io: File.open(supplier_details_file_path), filename: 'test_supplier_details_file.xlsx')
      admin_upload.supplier_rate_cards_file.attach(io: File.open(supplier_rate_cards_file_path), filename: 'test_supplier_rate_cards_file.xlsx')
      admin_upload.supplier_lot_1_service_offerings_file.attach(io: File.open(supplier_lot_1_service_offerings_file_path), filename: 'test_supplier_lot_1_service_offerings_file.xlsx')
      admin_upload.supplier_lot_2_service_offerings_file.attach(io: File.open(supplier_lot_2_service_offerings_file_path), filename: 'test_supplier_lot_2_service_offerings_file.xlsx')
      admin_upload.supplier_lot_3_service_offerings_file.attach(io: File.open(supplier_lot_3_service_offerings_file_path), filename: 'test_supplier_lot_3_service_offerings_file.xlsx')
      admin_upload.supplier_lot_4_service_offerings_file.attach(io: File.open(supplier_lot_4_service_offerings_file_path), filename: 'test_supplier_lot_4_service_offerings_file.xlsx')
    end
  end

  let(:supplier_details_file) { LegalServices::RM3788::SupplierDetailsFile.new(**supplier_details_file_options) }
  let(:supplier_details_file_path) { LegalServices::RM3788::SupplierDetailsFile::OUTPUT_PATH }
  let(:supplier_details_file_options) { {} }

  let(:supplier_rate_cards_file) { LegalServices::RM3788::SupplierRateCardsFile.new(**supplier_rate_cards_file_options) }
  let(:supplier_rate_cards_file_path) { LegalServices::RM3788::SupplierRateCardsFile::OUTPUT_PATH }
  let(:supplier_rate_cards_file_options) { {} }

  let(:supplier_lot_1_service_offerings_file) { LegalServices::RM3788::SupplierLot1File.new(**supplier_lot_1_service_offerings_file_options) }
  let(:supplier_lot_1_service_offerings_file_path) { LegalServices::RM3788::SupplierLot1File::OUTPUT_PATH }
  let(:supplier_lot_1_service_offerings_file_options) { {} }

  let(:supplier_lot_2_service_offerings_file) { LegalServices::RM3788::SupplierLot2File.new(**supplier_lot_2_service_offerings_file_options) }
  let(:supplier_lot_2_service_offerings_file_path) { LegalServices::RM3788::SupplierLot2File::OUTPUT_PATH }
  let(:supplier_lot_2_service_offerings_file_options) { {} }

  let(:supplier_lot_3_service_offerings_file) { LegalServices::RM3788::SupplierLot3File.new(**supplier_lot_3_service_offerings_file_options) }
  let(:supplier_lot_3_service_offerings_file_path) { LegalServices::RM3788::SupplierLot3File::OUTPUT_PATH }
  let(:supplier_lot_3_service_offerings_file_options) { {} }

  let(:supplier_lot_4_service_offerings_file) { LegalServices::RM3788::SupplierLot4File.new(**supplier_lot_4_service_offerings_file_options) }
  let(:supplier_lot_4_service_offerings_file_path) { LegalServices::RM3788::SupplierLot4File::OUTPUT_PATH }
  let(:supplier_lot_4_service_offerings_file_options) { {} }

  let(:files_importer) { described_class.new(upload) }

  before do
    LegalServices::RM3788::Admin::Upload::ATTRIBUTES.each do |file|
      send(file).build
      send(file).write
    end

    files_importer.import_data
  end

  describe 'check_files' do
    context 'when the files have the wrong sheets' do
      let(:supplier_details_file_options) { { sheets: ['All regions'] } }
      let(:supplier_rate_cards_file_options) { { sheets: ['Lot 1a', 'Lot 2a - England & Wales', 'Lot 2b - Scotland', 'Lot 2c - Northern Ireland', 'Lot 3', 'Lot 4'] } }
      let(:supplier_lot_1_service_offerings_file_options) { { sheets: ['Full UK Coverage', 'North East England (NUTS C)', 'North West England (NUTS D)', 'Yorkshire & Humberside (NUTS E)', 'East Midlands (NUTS F)', 'West Midlands (NUTS G)', 'East of England (NUTS H)', 'Greater London (NUTS I)', 'South East England (NUTS J)', 'South West England (NUTS K)', 'Scotland (NUTS M)', 'Northern Ireland (NUTS N)'] } }
      let(:supplier_lot_2_service_offerings_file_options) { { sheets: ['Lot 2b - England & Wales', 'Lot 2c - Scotland', 'Lot 2d - Northern Ireland'] } }
      let(:supplier_lot_3_service_offerings_file_options) { { sheets: ['All services'] } }
      let(:supplier_lot_4_service_offerings_file_options) { { sheets: ['All services'] } }

      it 'changes the state to failed and has the correct errors' do
        expect(upload).to have_state(:failed)
        expect(upload.import_errors).to eq [{ error: 'supplier_details_missing_sheets' },
                                            { error: 'supplier_rate_cards_missing_sheets' },
                                            { error: 'supplier_lot_1_service_offerings_missing_sheets' },
                                            { error: 'supplier_lot_2_service_offerings_missing_sheets' },
                                            { error: 'supplier_lot_3_service_offerings_missing_sheets' },
                                            { error: 'supplier_lot_4_service_offerings_missing_sheets' }]
      end
    end

    context 'when the files have the wrong headers and columns' do
      let(:supplier_details_file_options) { { headers: LegalServices::RM3788::SupplierDetailsFile.sheets_with_extra_headers(['All Suppliers']) } }
      let(:supplier_rate_cards_file_options) { { headers: LegalServices::RM3788::SupplierRateCardsFile.sheets_with_extra_headers(['Lot 1', 'Lot 2b - Scotland', 'Lot 4']) } }
      let(:supplier_lot_1_service_offerings_file_options) { { headers: LegalServices::RM3788::SupplierLot1File.sheets_with_extra_headers(['North West England (NUTS D)', 'Yorkshire & Humberside (NUTS E)', 'East Midlands (NUTS F)']) } }
      let(:supplier_lot_2_service_offerings_file_options) { { headers: LegalServices::RM3788::SupplierLot2File.sheets_with_extra_headers(['Lot 2c - Northern Ireland']) } }
      let(:supplier_lot_3_service_offerings_file_options) { { headers: LegalServices::RM3788::SupplierLot3File.sheets_with_extra_headers(['All regions']) } }
      let(:supplier_lot_4_service_offerings_file_options) { { headers: LegalServices::RM3788::SupplierLot4File.sheets_with_extra_headers(['All regions']) } }

      it 'changes the state to failed and has the correct errors' do
        expect(upload).to have_state(:failed)
        expect(upload.import_errors).to eq [{ error: 'supplier_details_has_incorrect_headers' },
                                            { error: 'supplier_rate_cards_has_incorrect_headers', details: ['Lot 1', 'Lot 2b - Scotland', 'Lot 4'] },
                                            { error: 'supplier_lot_1_service_offerings_has_incorrect_headers', details: ['North West England (NUTS D)', 'Yorkshire & Humberside (NUTS E)', 'East Midlands (NUTS F)'] },
                                            { error: 'supplier_lot_2_service_offerings_has_incorrect_headers', details: ['Lot 2c - Northern Ireland'] },
                                            { error: 'supplier_lot_3_service_offerings_has_incorrect_headers' },
                                            { error: 'supplier_lot_4_service_offerings_has_incorrect_headers' }]
      end
    end

    context 'when the files are empty' do
      let(:supplier_details_file_options) { { empty: true } }
      let(:supplier_rate_cards_file_options) { { empty: true } }
      let(:supplier_lot_1_service_offerings_file_options) { { empty: true } }
      let(:supplier_lot_2_service_offerings_file_options) { { empty: true } }
      let(:supplier_lot_3_service_offerings_file_options) { { empty: true } }
      let(:supplier_lot_4_service_offerings_file_options) { { empty: true } }

      it 'changes the state to failed and has the correct errors' do
        expect(upload).to have_state(:failed)
        expect(upload.import_errors).to eq [{ error: 'supplier_details_has_empty_sheets' },
                                            { error: 'supplier_rate_cards_has_empty_sheets', details: ['Lot 1', 'Lot 2a - England & Wales', 'Lot 2b - Scotland', 'Lot 2c - Northern Ireland', 'Lot 3', 'Lot 4'] },
                                            { error: 'supplier_lot_1_service_offerings_has_empty_sheets', details: ['Full UK Coverage', 'North East England (NUTS C)', 'North West England (NUTS D)', 'Yorkshire & Humberside (NUTS E)', 'East Midlands (NUTS F)', 'West Midlands (NUTS G)', 'East of England (NUTS H)', 'Greater London (NUTS I)', 'South East England (NUTS J)', 'South West England (NUTS K)', 'Wales (NUTS L)', 'Scotland (NUTS M)', 'Northern Ireland (NUTS N)'] },
                                            { error: 'supplier_lot_2_service_offerings_has_empty_sheets', details: ['Lot 2a - England & Wales', 'Lot 2b - Scotland', 'Lot 2c - Northern Ireland'] },
                                            { error: 'supplier_lot_3_service_offerings_has_empty_sheets' },
                                            { error: 'supplier_lot_4_service_offerings_has_empty_sheets' }]
      end
    end
  end

  describe 'check_processed_data' do
    context 'when a supplier has no lots' do
      let(:supplier_lot_4_service_offerings_file_options) { { supplier_duns: { 'MALSO LTD': '987654321' } } }

      it 'changes the state to failed and has the correct errors' do
        expect(upload).to have_state(:failed)
        expect(upload.import_errors).to eq [{ error: 'supplier_missing_lots', details: ['MALSO LTD'] }]
      end
    end

    context 'when a supplier has no rate cards' do
      let(:supplier_rate_cards_file_options) { { supplier_duns: { 'MORAG JEWEL LTD': '987654321' } } }

      it 'changes the state to failed and has the correct errors' do
        expect(upload).to have_state(:failed)
        expect(upload.import_errors).to eq [{ error: 'supplier_missing_rate_cards', details: ['MORAG JEWEL LTD'] }]
      end
    end
  end

  describe 'import_data' do
    let(:expected_supplier_results) do
      {
        'REX LTD': { regional_availabilities: 117, service_offerings: 1, rate_cards: 2 },
        'NIA CORP': { regional_availabilities: 130, service_offerings: 0, rate_cards: 1 },
        'TORA LTD': { regional_availabilities: 117, service_offerings: 69, rate_cards: 4 },
        'VANDHAM EXEC CORP': { regional_availabilities: 0, service_offerings: 72, rate_cards: 3 },
        'MORAG JEWEL LTD': { regional_availabilities: 0, service_offerings: 70, rate_cards: 4 },
        'ZEKE VON GEMBU CORP': { regional_availabilities: 0, service_offerings: 1, rate_cards: 1 },
        'JIN CORP': { regional_availabilities: 0, service_offerings: 2, rate_cards: 2 },
        'MALSO LTD': { regional_availabilities: 0, service_offerings: 1, rate_cards: 1 }
      }
    end

    it 'publishes the data and all the suppliers are imported' do
      expect(upload).to have_state(:published)
      expect(LegalServices::RM3788::Supplier.count).to eq 8
    end

    it 'has the correct data for the suppliers' do
      expected_supplier_results.each do |name, expected_results|
        supplier = LegalServices::RM3788::Supplier.find_by(name: name)

        expect(supplier.regional_availabilities.count).to eq expected_results[:regional_availabilities]
        expect(supplier.service_offerings.count).to eq expected_results[:service_offerings]
        expect(supplier.rate_cards.count).to eq expected_results[:rate_cards]
      end
    end
  end
end

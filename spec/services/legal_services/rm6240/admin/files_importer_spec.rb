require 'rails_helper'

module LegalServices::RM6240::Admin
  RSpec.describe FilesImporter do
    let(:upload) do
      create(:legal_services_rm6240_admin_upload, aasm_state: 'in_progress') do |admin_upload|
        admin_upload.supplier_details_file.attach(io: File.open(supplier_details_file_path), filename: 'test_supplier_details_file.xlsx')
        admin_upload.supplier_rate_cards_file.attach(io: File.open(supplier_rate_cards_file_path), filename: 'test_supplier_rate_cards_file.xlsx')
        admin_upload.supplier_lot_1_service_offerings_file.attach(io: File.open(supplier_lot_1_service_offerings_file_path), filename: 'test_supplier_lot_1_service_offerings_file.xlsx')
        admin_upload.supplier_lot_2_service_offerings_file.attach(io: File.open(supplier_lot_2_service_offerings_file_path), filename: 'test_supplier_lot_2_service_offerings_file.xlsx')
        admin_upload.supplier_lot_3_service_offerings_file.attach(io: File.open(supplier_lot_3_service_offerings_file_path), filename: 'test_supplier_lot_3_service_offerings_file.xlsx')
      end
    end

    let(:supplier_details_file) { SupplierDetailsFile.new(**supplier_details_file_options) }
    let(:supplier_details_file_path) { SupplierDetailsFile::OUTPUT_PATH }
    let(:supplier_details_file_options) { {} }

    let(:supplier_rate_cards_file) { SupplierRateCardsFile.new(**supplier_rate_cards_file_options) }
    let(:supplier_rate_cards_file_path) { SupplierRateCardsFile::OUTPUT_PATH }
    let(:supplier_rate_cards_file_options) { {} }

    let(:supplier_lot_1_service_offerings_file) { SupplierLot1File.new(**supplier_lot_1_service_offerings_file_options) }
    let(:supplier_lot_1_service_offerings_file_path) { SupplierLot1File::OUTPUT_PATH }
    let(:supplier_lot_1_service_offerings_file_options) { {} }

    let(:supplier_lot_2_service_offerings_file) { SupplierLot2File.new(**supplier_lot_2_service_offerings_file_options) }
    let(:supplier_lot_2_service_offerings_file_path) { SupplierLot2File::OUTPUT_PATH }
    let(:supplier_lot_2_service_offerings_file_options) { {} }

    let(:supplier_lot_3_service_offerings_file) { SupplierLot3File.new(**supplier_lot_3_service_offerings_file_options) }
    let(:supplier_lot_3_service_offerings_file_path) { SupplierLot3File::OUTPUT_PATH }
    let(:supplier_lot_3_service_offerings_file_options) { {} }

    let(:files_importer) { described_class.new(upload) }

    before do
      Upload::ATTRIBUTES.each do |file|
        send(file).build
        send(file).write
      end

      files_importer.import_data
    end

    describe 'check_files' do
      context 'when the files have the wrong sheets' do
        let(:supplier_details_file_options) { { sheets: ['All regions'] } }
        let(:supplier_rate_cards_file_options) { { sheets: ['Lot 1', 'Lot 2a - England & Wales', 'Lot 2b - Scotland', 'Lot 2c - Northern Ireland', 'Lot 3', 'Lot 4'] } }
        let(:supplier_lot_1_service_offerings_file_options) { { sheets: ['Lot 1b - England & Wales', 'Lot 1c - Scotland', 'Lot 1d - Northern Ireland'] } }
        let(:supplier_lot_2_service_offerings_file_options) { { sheets: ['Lot 2b - England & Wales', 'Lot 2c - Scotland', 'Lot 2d - Northern Ireland'] } }
        let(:supplier_lot_3_service_offerings_file_options) { { sheets: ['All services'] } }

        it 'changes the state to failed and has the correct errors' do
          expect(upload).to have_state(:failed)
          expect(upload.import_errors).to eq [{ error: 'supplier_details_missing_sheets' },
                                              { error: 'supplier_rate_cards_missing_sheets' },
                                              { error: 'supplier_lot_1_service_offerings_missing_sheets' },
                                              { error: 'supplier_lot_2_service_offerings_missing_sheets' },
                                              { error: 'supplier_lot_3_service_offerings_missing_sheets' }]
        end
      end

      context 'when the files have the wrong headers and columns' do
        let(:supplier_details_file_options) { { headers: SupplierDetailsFile.sheets_with_extra_headers(['All Suppliers']) } }
        let(:supplier_rate_cards_file_options) { { headers: SupplierRateCardsFile.sheets_with_extra_headers(['Lot 1a - England & Wales', 'Lot 2b - Scotland', 'Lot 3']) } }
        let(:supplier_lot_1_service_offerings_file_options) { { headers: SupplierLot1File.sheets_with_extra_headers(['Lot 1b - Scotland']) } }
        let(:supplier_lot_2_service_offerings_file_options) { { headers: SupplierLot2File.sheets_with_extra_headers(['Lot 2c - Northern Ireland']) } }
        let(:supplier_lot_3_service_offerings_file_options) { { headers: SupplierLot3File.sheets_with_extra_headers(['All regions']) } }

        it 'changes the state to failed and has the correct errors' do
          expect(upload).to have_state(:failed)
          expect(upload.import_errors).to eq [{ error: 'supplier_details_has_incorrect_headers' },
                                              { error: 'supplier_rate_cards_has_incorrect_headers', details: ['Lot 1a - England & Wales', 'Lot 2b - Scotland', 'Lot 3'] },
                                              { error: 'supplier_lot_1_service_offerings_has_incorrect_headers', details: ['Lot 1b - Scotland'] },
                                              { error: 'supplier_lot_2_service_offerings_has_incorrect_headers', details: ['Lot 2c - Northern Ireland'] },
                                              { error: 'supplier_lot_3_service_offerings_has_incorrect_headers', details: ['All regions'] }]
        end
      end

      context 'when the files are empty' do
        let(:supplier_details_file_options) { { empty: true } }
        let(:supplier_rate_cards_file_options) { { empty: true } }
        let(:supplier_lot_1_service_offerings_file_options) { { empty: true } }
        let(:supplier_lot_2_service_offerings_file_options) { { empty: true } }
        let(:supplier_lot_3_service_offerings_file_options) { { empty: true } }

        it 'changes the state to failed and has the correct errors' do
          expect(upload).to have_state(:failed)
          expect(upload.import_errors).to eq [{ error: 'supplier_details_has_empty_sheets' },
                                              { error: 'supplier_rate_cards_has_empty_sheets', details: ['Lot 1a - England & Wales', 'Lot 1b - Scotland', 'Lot 1c - Northern Ireland', 'Lot 2a - England & Wales', 'Lot 2b - Scotland', 'Lot 2c - Northern Ireland', 'Lot 3'] },
                                              { error: 'supplier_lot_1_service_offerings_has_empty_sheets', details: ['Lot 1a - England & Wales', 'Lot 1b - Scotland', 'Lot 1c - Northern Ireland'] },
                                              { error: 'supplier_lot_2_service_offerings_has_empty_sheets', details: ['Lot 2a - England & Wales', 'Lot 2b - Scotland', 'Lot 2c - Northern Ireland'] },
                                              { error: 'supplier_lot_3_service_offerings_has_empty_sheets', details: ['All regions'] }]
        end
      end
    end

    describe 'check_processed_data' do
      context 'when a supplier has no services' do
        let(:supplier_lot_3_service_offerings_file_options) { { supplier_duns: { 'EUNIE CORP': '987654321' } } }

        it 'changes the state to failed and has the correct errors' do
          expect(upload).to have_state(:failed)
          expect(upload.import_errors).to eq [{ error: 'supplier_missing_services', details: ['EUNIE CORP'] }]
        end
      end

      context 'when a supplier has no rate cards' do
        let(:supplier_rate_cards_file_options) { { supplier_duns: { 'ETHEL LTD': '987654321' } } }

        it 'changes the state to failed and has the correct errors' do
          expect(upload).to have_state(:failed)
          expect(upload.import_errors).to eq [{ error: 'supplier_missing_rates', details: ['ETHEL LTD'] }]
        end
      end
    end

    describe 'import_data' do
      let(:expected_supplier_results) do
        {
          'NOAH LTD': { lots: 3, services: 78, rates: 21 },
          'MIO CORP': { lots: 3, services: 81, rates: 21 },
          'REKU LTD': { lots: 6, services: 111, rates: 42 },
          'GUERNICA EXEC CORP': { lots: 3, services: 30, rates: 21 },
          'ETHEL LTD': { lots: 4, services: 31, rates: 28 },
          'LANZ CORP': { lots: 1, services: 1, rates: 7 },
          'EUNIE CORP': { lots: 1, services: 1, rates: 7 }
        }
      end

      it 'publishes the data and all the suppliers are imported' do
        expect(upload).to have_state(:published)
        expect(Supplier::Framework.where(framework_id: 'RM6240').count).to eq 7
      end

      it 'has the correct data for the suppliers' do
        expected_supplier_results.each do |name, expected_results|
          supplier_framework = Supplier.find_by(name:).supplier_frameworks.find_by(framework_id: 'RM6240')

          expect(supplier_framework.lots.count).to eq expected_results[:lots]
          expect(supplier_framework.lots.sum { |lot| lot.services.count }).to eq expected_results[:services]
          expect(supplier_framework.lots.sum { |lot| lot.rates.count }).to eq expected_results[:rates]
        end
      end
    end
  end
end

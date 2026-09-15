require 'rails_helper'

module LegalServices::RM6374::Admin
  RSpec.describe FilesImporter do
    let(:upload) do
      create(:legal_services_rm6374_admin_upload, aasm_state: 'in_progress') do |admin_upload|
        File.open(supplier_details_file_path, 'rb') do |file_stream|
          admin_upload.supplier_details_file.attach(io: file_stream, filename: 'test_supplier_details_file.xlsx')
        end
        File.open(supplier_rate_cards_file_path, 'rb') do |file_stream|
          admin_upload.supplier_rate_cards_file.attach(io: file_stream, filename: 'test_supplier_rate_cards_file.xlsx')
        end
        File.open(supplier_lot_1a_service_offerings_file_path, 'rb') do |file_stream|
          admin_upload.supplier_lot_1a_service_offerings_file.attach(io: file_stream, filename: 'test_supplier_lot_1a_service_offerings_file.xlsx')
        end
        File.open(supplier_lot_1b_service_offerings_file_path, 'rb') do |file_stream|
          admin_upload.supplier_lot_1b_service_offerings_file.attach(io: file_stream, filename: 'test_supplier_lot_1b_service_offerings_file.xlsx')
        end
        File.open(supplier_lot_1c_service_offerings_file_path, 'rb') do |file_stream|
          admin_upload.supplier_lot_1c_service_offerings_file.attach(io: file_stream, filename: 'test_supplier_lot_1c_service_offerings_file.xlsx')
        end
        File.open(supplier_lot_2_service_offerings_file_path, 'rb') do |file_stream|
          admin_upload.supplier_lot_2_service_offerings_file.attach(io: file_stream, filename: 'test_supplier_lot_2_service_offerings_file.xlsx')
        end
        File.open(supplier_lot_3_service_offerings_file_path, 'rb') do |file_stream|
          admin_upload.supplier_lot_3_service_offerings_file.attach(io: file_stream, filename: 'test_supplier_lot_3_service_offerings_file.xlsx')
        end
        File.open(supplier_lot_4_service_offerings_file_path, 'rb') do |file_stream|
          admin_upload.supplier_lot_4_service_offerings_file.attach(io: file_stream, filename: 'test_supplier_lot_4_service_offerings_file.xlsx')
        end
        File.open(supplier_lot_5_service_offerings_file_path, 'rb') do |file_stream|
          admin_upload.supplier_lot_5_service_offerings_file.attach(io: file_stream, filename: 'test_supplier_lot_5_service_offerings_file.xlsx')
        end
        File.open(supplier_lot_6_service_offerings_file_path, 'rb') do |file_stream|
          admin_upload.supplier_lot_6_service_offerings_file.attach(io: file_stream, filename: 'test_supplier_lot_6_service_offerings_file.xlsx')
        end
      end
    end

    let(:supplier_details_file) { SupplierDetailsFile.new(**supplier_details_file_options) }
    let(:supplier_details_file_path) { SupplierDetailsFile::OUTPUT_PATH }
    let(:supplier_details_file_options) { {} }

    let(:supplier_rate_cards_file) { SupplierRateCardsFile.new(**supplier_rate_cards_file_options) }
    let(:supplier_rate_cards_file_path) { SupplierRateCardsFile::OUTPUT_PATH }
    let(:supplier_rate_cards_file_options) { {} }

    let(:supplier_lot_1a_service_offerings_file) { SupplierLot1AFile.new(**supplier_lot_1a_service_offerings_file_options) }
    let(:supplier_lot_1a_service_offerings_file_path) { SupplierLot1AFile::OUTPUT_PATH }
    let(:supplier_lot_1a_service_offerings_file_options) { {} }

    let(:supplier_lot_1b_service_offerings_file) { SupplierLot1BFile.new(**supplier_lot_1b_service_offerings_file_options) }
    let(:supplier_lot_1b_service_offerings_file_path) { SupplierLot1BFile::OUTPUT_PATH }
    let(:supplier_lot_1b_service_offerings_file_options) { {} }

    let(:supplier_lot_1c_service_offerings_file) { SupplierLot1CFile.new(**supplier_lot_1c_service_offerings_file_options) }
    let(:supplier_lot_1c_service_offerings_file_path) { SupplierLot1CFile::OUTPUT_PATH }
    let(:supplier_lot_1c_service_offerings_file_options) { {} }

    let(:supplier_lot_2_service_offerings_file) { SupplierLot2File.new(**supplier_lot_2_service_offerings_file_options) }
    let(:supplier_lot_2_service_offerings_file_path) { SupplierLot2File::OUTPUT_PATH }
    let(:supplier_lot_2_service_offerings_file_options) { {} }

    let(:supplier_lot_3_service_offerings_file) { SupplierLot3File.new(**supplier_lot_3_service_offerings_file_options) }
    let(:supplier_lot_3_service_offerings_file_path) { SupplierLot3File::OUTPUT_PATH }
    let(:supplier_lot_3_service_offerings_file_options) { {} }

    let(:supplier_lot_4_service_offerings_file) { SupplierLot4File.new(**supplier_lot_4_service_offerings_file_options) }
    let(:supplier_lot_4_service_offerings_file_path) { SupplierLot4File::OUTPUT_PATH }
    let(:supplier_lot_4_service_offerings_file_options) { {} }

    let(:supplier_lot_5_service_offerings_file) { SupplierLot5File.new(**supplier_lot_5_service_offerings_file_options) }
    let(:supplier_lot_5_service_offerings_file_path) { SupplierLot5File::OUTPUT_PATH }
    let(:supplier_lot_5_service_offerings_file_options) { {} }

    let(:supplier_lot_6_service_offerings_file) { SupplierLot6File.new(**supplier_lot_6_service_offerings_file_options) }
    let(:supplier_lot_6_service_offerings_file_path) { SupplierLot6File::OUTPUT_PATH }
    let(:supplier_lot_6_service_offerings_file_options) { {} }

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
        let(:supplier_rate_cards_file_options) { { sheets: ['1a', '1b', '1c', '3', '4', '5', '6'] } }
        let(:supplier_lot_1a_service_offerings_file_options) { { sheets: ['Scotland', 'Northern Ireland'] } }
        let(:supplier_lot_1b_service_offerings_file_options) { { sheets: ['England & Wales', 'Northern Ireland'] } }
        let(:supplier_lot_1c_service_offerings_file_options) { { sheets: ['England & Wales', 'Scotland'] } }
        let(:supplier_lot_2_service_offerings_file_options) { { sheets: ['Scotland', 'Northern Ireland'] } }
        let(:supplier_lot_3_service_offerings_file_options) { { sheets: ['England & Wales', 'Northern Ireland'] } }
        let(:supplier_lot_4_service_offerings_file_options) { { sheets: ['England & Wales', 'Scotland'] } }
        let(:supplier_lot_5_service_offerings_file_options) { { sheets: ['England & Wales', 'Northern Ireland'] } }
        let(:supplier_lot_6_service_offerings_file_options) { { sheets: ['something'] } }

        it 'changes the state to failed and has the correct errors' do # rubocop:disable RSpec/ExampleLength
          expect(upload).to have_state(:failed)
          expect(upload.import_errors).to eq [{ error: 'supplier_details_missing_sheets' },
                                              { error: 'supplier_rate_cards_missing_sheets' },
                                              { error: 'supplier_lot_1a_service_offerings_missing_sheets' },
                                              { error: 'supplier_lot_1b_service_offerings_missing_sheets' },
                                              { error: 'supplier_lot_1c_service_offerings_missing_sheets' },
                                              { error: 'supplier_lot_2_service_offerings_missing_sheets' },
                                              { error: 'supplier_lot_3_service_offerings_missing_sheets' },
                                              { error: 'supplier_lot_4_service_offerings_missing_sheets' },
                                              { error: 'supplier_lot_5_service_offerings_missing_sheets' },
                                              { error: 'supplier_lot_6_service_offerings_missing_sheets' }]
        end
      end

      context 'when the files have the wrong headers and columns' do
        let(:supplier_details_file_options) { { headers: SupplierDetailsFile.sheets_with_extra_headers(['All Suppliers']) } }
        let(:supplier_rate_cards_file_options) { { headers: SupplierRateCardsFile.sheets_with_extra_headers(['1a', '2', '6']) } }
        let(:supplier_lot_1a_service_offerings_file_options) { { headers: SupplierLot1AFile.sheets_with_extra_headers(['England & Wales']) } }
        let(:supplier_lot_1b_service_offerings_file_options) { { headers: SupplierLot1BFile.sheets_with_extra_headers(['England & Wales']) } }
        let(:supplier_lot_1c_service_offerings_file_options) { { headers: SupplierLot1CFile.sheets_with_extra_headers(['Scotland']) } }
        let(:supplier_lot_2_service_offerings_file_options) { { headers: SupplierLot2File.sheets_with_extra_headers(['Scotland']) } }
        let(:supplier_lot_3_service_offerings_file_options) { { headers: SupplierLot3File.sheets_with_extra_headers(['Northern Ireland']) } }
        let(:supplier_lot_4_service_offerings_file_options) { { headers: SupplierLot4File.sheets_with_extra_headers(['Northern Ireland']) } }
        let(:supplier_lot_5_service_offerings_file_options) { { headers: SupplierLot5File.sheets_with_extra_headers(['Scotland']) } }
        let(:supplier_lot_6_service_offerings_file_options) { { headers: SupplierLot6File.sheets_with_extra_headers(['All regions']) } }

        it 'changes the state to failed and has the correct errors' do # rubocop:disable RSpec/ExampleLength
          expect(upload).to have_state(:failed)
          expect(upload.import_errors).to eq [{ error: 'supplier_details_has_incorrect_headers' },
                                              { error: 'supplier_rate_cards_has_incorrect_headers', details: ['1a', '2', '6'] },
                                              { error: 'supplier_lot_1a_service_offerings_has_incorrect_headers', details: ['England & Wales'] },
                                              { error: 'supplier_lot_1b_service_offerings_has_incorrect_headers', details: ['England & Wales'] },
                                              { error: 'supplier_lot_1c_service_offerings_has_incorrect_headers', details: ['Scotland'] },
                                              { error: 'supplier_lot_2_service_offerings_has_incorrect_headers', details: ['Scotland'] },
                                              { error: 'supplier_lot_3_service_offerings_has_incorrect_headers', details: ['Northern Ireland'] },
                                              { error: 'supplier_lot_4_service_offerings_has_incorrect_headers', details: ['Northern Ireland'] },
                                              { error: 'supplier_lot_5_service_offerings_has_incorrect_headers', details: ['Scotland'] },
                                              { error: 'supplier_lot_6_service_offerings_has_incorrect_headers', details: ['All regions'] }]
        end
      end

      context 'when the files are empty' do
        let(:supplier_details_file_options) { { empty: true } }
        let(:supplier_rate_cards_file_options) { { empty: true } }
        let(:supplier_lot_1a_service_offerings_file_options) { { empty: true } }
        let(:supplier_lot_2_service_offerings_file_options) { { empty: true } }
        let(:supplier_lot_3_service_offerings_file_options) { { empty: true } }
        let(:supplier_lot_6_service_offerings_file_options) { { empty: true } }

        it 'changes the state to failed and has the correct errors' do
          expect(upload).to have_state(:failed)
          expect(upload.import_errors).to eq [{ error: 'supplier_details_has_empty_sheets' },
                                              { error: 'supplier_rate_cards_has_empty_sheets', details: ['1a', '1b', '1c', '2', '3', '4', '5', '6'] },
                                              { error: 'supplier_lot_1a_service_offerings_has_empty_sheets', details: ['England & Wales', 'Scotland', 'Northern Ireland'] },
                                              { error: 'supplier_lot_2_service_offerings_has_empty_sheets', details: ['England & Wales', 'Scotland', 'Northern Ireland'] },
                                              { error: 'supplier_lot_3_service_offerings_has_empty_sheets', details: ['England & Wales', 'Scotland', 'Northern Ireland'] },
                                              { error: 'supplier_lot_6_service_offerings_has_empty_sheets', details: ['All regions'] }]
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
          'NOAH LTD': { lots: 3, services: 120, jurisdictions: 9, rates: 81 },
          'MIO CORP': { lots: 3, services: 120, jurisdictions: 9, rates: 81 },
          'REKU LTD': { lots: 4, services: 166, jurisdictions: 12, rates: 108 },
          'GUERNICA EXEC CORP': { lots: 1, services: 46, jurisdictions: 3, rates: 27 },
          'ETHEL LTD': { lots: 5, services: 76, jurisdictions: 13, rates: 112 },
          'LANZ CORP': { lots: 4, services: 32, jurisdictions: 10, rates: 85 },
          'EUNIE CORP': { lots: 4, services: 30, jurisdictions: 10, rates: 85 }
        }
      end
      let(:change_log) { ChangeLog.find_by(user_id: upload.user_id, framework_id: 'RM6374') }

      it 'publishes the data and all the suppliers are imported' do
        expect(upload).to have_state(:published)
        expect(Supplier::Framework.where(framework_id: 'RM6374').count).to eq 7
      end

      it 'creates a change log' do
        expect(change_log.change_type).to eq('upload_supplier_data')
        expect(change_log.change_data['admin_upload_id']).to eq(upload.id)
        expect(change_log.change_data['supplier_data'].length).to eq(7)
      end

      # rubocop:disable RSpec/MultipleExpectations
      it 'has the correct data for the suppliers' do
        expected_supplier_results.each do |name, expected_results|
          supplier_framework = Supplier.find_by(name:).supplier_frameworks.find_by(framework_id: 'RM6374')

          expect(supplier_framework.lots.count).to eq expected_results[:lots]
          expect(supplier_framework.lots.sum { |lot| lot.services.count }).to eq expected_results[:services]
          expect(supplier_framework.lots.sum { |lot| lot.jurisdictions.count }).to eq expected_results[:jurisdictions]
          expect(supplier_framework.lots.sum { |lot| lot.rates.count }).to eq expected_results[:rates]
        end
      end
      # rubocop:enable RSpec/MultipleExpectations
    end
  end
end

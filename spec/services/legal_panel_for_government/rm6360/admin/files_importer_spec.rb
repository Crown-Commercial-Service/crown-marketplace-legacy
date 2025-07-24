require 'rails_helper'

module LegalPanelForGovernment::RM6360::Admin
  RSpec.describe FilesImporter do
    let(:upload) do
      create(:legal_panel_for_government_rm6360_admin_upload, aasm_state: 'in_progress') do |admin_upload|
        admin_upload.supplier_details_file.attach(io: File.open(supplier_details_file_path), filename: 'test_supplier_details_file.xlsx')
        admin_upload.supplier_service_offerings_file.attach(io: File.open(supplier_service_offerings_file_path), filename: 'test_supplier_service_offerings_file.xlsx')
        admin_upload.supplier_other_lots_rate_cards_file.attach(io: File.open(supplier_other_lots_rate_cards_file_path), filename: 'test_supplier_other_lots_rate_cards_file.xlsx')
        admin_upload.supplier_lot_4a_rate_cards_file.attach(io: File.open(supplier_lot_4a_rate_cards_file_path), filename: 'test_supplier_lot_4a_rate_cards_file.xlsx')
        admin_upload.supplier_lot_4b_rate_cards_file.attach(io: File.open(supplier_lot_4b_rate_cards_file_path), filename: 'test_supplier_lot_4b_rate_cards_file.xlsx')
        admin_upload.supplier_lot_4c_rate_cards_file.attach(io: File.open(supplier_lot_4c_rate_cards_file_path), filename: 'test_supplier_lot_4c_rate_cards_file.xlsx')
      end
    end

    let(:supplier_details_file) { SupplierDetailsFile.new(**supplier_details_file_options) }
    let(:supplier_details_file_path) { SupplierDetailsFile::OUTPUT_PATH }
    let(:supplier_details_file_options) { {} }

    let(:supplier_service_offerings_file) { SupplierServiceOfferingsFile.new(**supplier_service_offerings_file_options) }
    let(:supplier_service_offerings_file_path) { SupplierServiceOfferingsFile::OUTPUT_PATH }
    let(:supplier_service_offerings_file_options) { {} }

    let(:supplier_other_lots_rate_cards_file) { SupplierOtherLotsRateCardsFile.new(**supplier_other_lots_rate_cards_file_options) }
    let(:supplier_other_lots_rate_cards_file_path) { SupplierOtherLotsRateCardsFile::OUTPUT_PATH }
    let(:supplier_other_lots_rate_cards_file_options) { {} }

    let(:supplier_lot_4a_rate_cards_file) { SupplierLot4aRateCardsFile.new(**supplier_lot_4a_rate_cards_file_options) }
    let(:supplier_lot_4a_rate_cards_file_path) { SupplierLot4aRateCardsFile::OUTPUT_PATH }
    let(:supplier_lot_4a_rate_cards_file_options) { {} }

    let(:supplier_lot_4b_rate_cards_file) { SupplierLot4bRateCardsFile.new(**supplier_lot_4b_rate_cards_file_options) }
    let(:supplier_lot_4b_rate_cards_file_path) { SupplierLot4bRateCardsFile::OUTPUT_PATH }
    let(:supplier_lot_4b_rate_cards_file_options) { {} }

    let(:supplier_lot_4c_rate_cards_file) { SupplierLot4cRateCardsFile.new(**supplier_lot_4c_rate_cards_file_options) }
    let(:supplier_lot_4c_rate_cards_file_path) { SupplierLot4cRateCardsFile::OUTPUT_PATH }
    let(:supplier_lot_4c_rate_cards_file_options) { {} }

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
        let(:supplier_service_offerings_file_options) { { sheets: ['Lot 1', 'Lot 2', 'Lot 3', 'Lot 4', 'Lot 5'] } }
        let(:supplier_other_lots_rate_cards_file_options) { { sheets: ['Lot 1', 'Lot 2', 'Lot 3', 'Lot 4a', 'Lot 4b', 'Lot 4c', 'Lot 5'] } }
        let(:supplier_lot_4a_rate_cards_file_options) { { sheets: ['Senior Counsel', 'Partner', 'Legal Director', 'Senior Solicitor', 'Solicitor', 'Trainee', 'Paralegal', 'Senior Analyst', 'Analyst', 'Senior Modeller', 'Modeller'] } }
        let(:supplier_lot_4b_rate_cards_file_options) { { sheets: ['Senior Counsel', 'Partner', 'Legal Director', 'Senior Solicitor', 'Solicitor', 'NQ Solicitor', 'Paralegal', 'Senior Analyst', 'Analyst', 'Senior Modeller', 'Modeller'] } }
        let(:supplier_lot_4c_rate_cards_file_options) { { sheets: ['Senior Counsel', 'Partner', 'Legal Director', 'Senior Solicitor', 'Solicitor', 'NQ Solicitor', 'Trainee', 'Senior Analyst', 'Analyst', 'Senior Modeller', 'Modeller'] } }

        it 'changes the state to failed and has the correct errors' do
          expect(upload).to have_state(:failed)
          expect(upload.import_errors).to eq [{ error: 'supplier_details_missing_sheets' },
                                              { error: 'supplier_service_offerings_missing_sheets' },
                                              { error: 'supplier_other_lots_rate_cards_missing_sheets' },
                                              { error: 'supplier_lot_4a_rate_cards_missing_sheets' },
                                              { error: 'supplier_lot_4b_rate_cards_missing_sheets' },
                                              { error: 'supplier_lot_4c_rate_cards_missing_sheets' }]
        end
      end

      context 'when the files have the wrong headers and columns' do
        let(:supplier_details_file_options) { { headers: SupplierDetailsFile.sheets_with_extra_headers(['All Suppliers']) } }
        let(:supplier_service_offerings_file_options) { { headers: SupplierServiceOfferingsFile.sheets_with_extra_headers(['Lot 1', 'Lot 3', 'Lot 4c']) } }
        let(:supplier_other_lots_rate_cards_file_options) { { headers: SupplierOtherLotsRateCardsFile.sheets_with_extra_headers(['Lot 2', 'Lot 5']) } }
        let(:supplier_lot_4a_rate_cards_file_options) { { headers: SupplierLot4aRateCardsFile.sheets_with_extra_headers(['Senior Counsel', 'Partner']) } }
        let(:supplier_lot_4b_rate_cards_file_options) { { headers: SupplierLot4bRateCardsFile.sheets_with_extra_headers(['Senior Solicitor', 'Solicitor']) } }
        let(:supplier_lot_4c_rate_cards_file_options) { { headers: SupplierLot4cRateCardsFile.sheets_with_extra_headers(['Senior Analyst', 'Analyst']) } }

        it 'changes the state to failed and has the correct errors' do
          expect(upload).to have_state(:failed)
          expect(upload.import_errors).to eq [{ error: 'supplier_details_has_incorrect_headers' },
                                              { error: 'supplier_service_offerings_has_incorrect_headers', details: ['Lot 1', 'Lot 3', 'Lot 4c'] },
                                              { error: 'supplier_other_lots_rate_cards_has_incorrect_headers', details: ['Lot 2', 'Lot 5'] },
                                              { error: 'supplier_lot_4a_rate_cards_has_incorrect_headers', details: ['Senior Counsel', 'Partner'] },
                                              { error: 'supplier_lot_4b_rate_cards_has_incorrect_headers', details: ['Senior Solicitor', 'Solicitor'] },
                                              { error: 'supplier_lot_4c_rate_cards_has_incorrect_headers', details: ['Senior Analyst', 'Analyst'] }]
        end
      end

      context 'when the files are empty' do
        let(:supplier_details_file_options) { { empty: true } }
        let(:supplier_service_offerings_file_options) { { empty: true } }
        let(:supplier_other_lots_rate_cards_file_options) { { empty: true } }
        let(:supplier_lot_4a_rate_cards_file_options) { { empty: true } }
        let(:supplier_lot_4b_rate_cards_file_options) { { empty: true } }
        let(:supplier_lot_4c_rate_cards_file_options) { { empty: true } }

        it 'changes the state to failed and has the correct errors' do
          expect(upload).to have_state(:failed)
          expect(upload.import_errors).to eq [{ error: 'supplier_details_has_empty_sheets' },
                                              { error: 'supplier_service_offerings_has_empty_sheets', details: ['Lot 1', 'Lot 2', 'Lot 3', 'Lot 4a', 'Lot 4b', 'Lot 4c', 'Lot 5',] },
                                              { error: 'supplier_other_lots_rate_cards_has_empty_sheets', details: ['Lot 1', 'Lot 2', 'Lot 3', 'Lot 5',] },
                                              { error: 'supplier_lot_4a_rate_cards_has_empty_sheets', details: ['Senior Counsel', 'Partner', 'Legal Director', 'Senior Solicitor', 'Solicitor', 'NQ Solicitor', 'Trainee', 'Paralegal', 'Senior Analyst', 'Analyst', 'Senior Modeller', 'Modeller'] },
                                              { error: 'supplier_lot_4b_rate_cards_has_empty_sheets', details: ['Senior Counsel', 'Partner', 'Legal Director', 'Senior Solicitor', 'Solicitor', 'NQ Solicitor', 'Trainee', 'Paralegal', 'Senior Analyst', 'Analyst', 'Senior Modeller', 'Modeller'] },
                                              { error: 'supplier_lot_4c_rate_cards_has_empty_sheets', details: ['Senior Counsel', 'Partner', 'Legal Director', 'Senior Solicitor', 'Solicitor', 'NQ Solicitor', 'Trainee', 'Paralegal', 'Senior Analyst', 'Analyst', 'Senior Modeller', 'Modeller'] }]
        end
      end
    end

    describe 'check_processed_data' do
      context 'when a supplier has no services' do
        let(:supplier_service_offerings_file_options) { { supplier_duns: { 'EUNIE CORP': '987654321' } } }

        it 'changes the state to failed and has the correct errors' do
          expect(upload).to have_state(:failed)
          expect(upload.import_errors).to eq [{ error: 'supplier_missing_services', details: ['EUNIE CORP'] }]
        end
      end

      context 'when a supplier has no rate cards' do
        let(:supplier_other_lots_rate_cards_file_options) { { supplier_duns: { 'ETHEL LTD': '987654321' } } }

        it 'changes the state to failed and has the correct errors' do
          expect(upload).to have_state(:failed)
          expect(upload.import_errors).to eq [{ error: 'supplier_missing_rates', details: ['ETHEL LTD'] }]
        end
      end

      context 'when a supplier has no rate cards for lot 4' do
        let(:supplier_lot_4a_rate_cards_file_options) { { supplier_duns: { 'SENA LTD': '987654321' } } }
        let(:supplier_lot_4b_rate_cards_file_options) { { supplier_duns: { 'SENA LTD': '987654321' } } }
        let(:supplier_lot_4c_rate_cards_file_options) { { supplier_duns: { 'SENA LTD': '987654321' } } }

        it 'changes the state to failed and has the correct errors' do
          expect(upload).to have_state(:failed)
          expect(upload.import_errors).to eq [{ error: 'supplier_missing_rates', details: ['SENA LTD'] }]
        end
      end
    end

    describe 'import_data' do
      let(:expected_supplier_results) do
        {
          'NOAH LTD': { lots: 1, services: 32, jurisdictions: 1, rates: 7 },
          'MIO CORP': { lots: 1, services: 32, jurisdictions: 1, rates: 7 },
          'REKU LTD': { lots: 2, services: 71, jurisdictions: 2, rates: 14 },
          'GUERNICA EXEC CORP': { lots: 1, services: 40, jurisdictions: 1, rates: 7 },
          'ETHEL LTD': { lots: 2, services: 54, jurisdictions: 2, rates: 14 },
          'LANZ CORP': { lots: 1, services: 16, jurisdictions: 1, rates: 7 },
          'EUNIE CORP': { lots: 4, services: 30, jurisdictions: 482, rates: 5767 },
          'SENA LTD': { lots: 3, services: 17, jurisdictions: 481, rates: 5760 },
          'TAION LTD': { lots: 4, services: 29, jurisdictions: 482, rates: 5767 },
          'NIMUE CORP': { lots: 1, services: 14, jurisdictions: 1, rates: 7 },
          'IZURD LTD': { lots: 1, services: 13, jurisdictions: 1, rates: 7 },
        }
      end

      it 'publishes the data and all the suppliers are imported' do
        expect(upload).to have_state(:published)
        expect(Supplier::Framework.where(framework_id: 'RM6360').count).to eq 11
      end

      # rubocop:disable RSpec/MultipleExpectations
      it 'has the correct data for the suppliers' do
        expected_supplier_results.each do |name, expected_results|
          supplier_framework = Supplier.find_by(name:).supplier_frameworks.find_by(framework_id: 'RM6360')

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

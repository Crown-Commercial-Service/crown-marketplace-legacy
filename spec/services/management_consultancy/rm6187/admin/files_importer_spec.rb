require 'rails_helper'

RSpec.describe ManagementConsultancy::RM6187::Admin::FilesImporter do
  let(:upload) do
    create(:management_consultancy_rm6187_admin_upload, aasm_state: 'in_progress') do |admin_upload|
      admin_upload.supplier_details_file.attach(io: File.open(supplier_details_file_path), filename: 'test_supplier_details_file.xlsx')
      admin_upload.supplier_rate_cards_file.attach(io: File.open(supplier_rate_cards_file_path), filename: 'test_supplier_rate_cards_file.xlsx')
      admin_upload.supplier_service_offerings_file.attach(io: File.open(supplier_service_offerings_file_path), filename: 'test_supplier_service_offerings_file.xlsx')
    end
  end

  let(:supplier_details_file) { ManagementConsultancy::RM6187::SupplierDetailsFile.new(**supplier_details_file_options) }
  let(:supplier_details_file_path) { ManagementConsultancy::RM6187::SupplierDetailsFile::OUTPUT_PATH }
  let(:supplier_details_file_options) { {} }

  let(:supplier_rate_cards_file) { ManagementConsultancy::RM6187::SupplierRateCardsFile.new(**supplier_rate_cards_file_options) }
  let(:supplier_rate_cards_file_path) { ManagementConsultancy::RM6187::SupplierRateCardsFile::OUTPUT_PATH }
  let(:supplier_rate_cards_file_options) { {} }

  let(:supplier_service_offerings_file) { ManagementConsultancy::RM6187::SupplierServiceOfferingsFile.new(**supplier_service_offerings_file_options) }
  let(:supplier_service_offerings_file_path) { ManagementConsultancy::RM6187::SupplierServiceOfferingsFile::OUTPUT_PATH }
  let(:supplier_service_offerings_file_options) { {} }

  let(:files_importer) { described_class.new(upload) }

  before do
    supplier_details_file.build
    supplier_details_file.write
    supplier_rate_cards_file.build
    supplier_rate_cards_file.write
    supplier_service_offerings_file.build
    supplier_service_offerings_file.write

    files_importer.import_data
  end

  describe 'check_files' do
    context 'when the files have the wrong sheets' do
      let(:supplier_details_file_options) { { sheets: ['MCF', 'MCF2', 'MCF3'] } }
      let(:supplier_rate_cards_file_options) { { sheets: ['MCF Lot 2', 'MCF Lot 3', 'MCF Lot 4', 'MCF Lot 5', 'MCF Lot 6', 'MCF Lot 7', 'MCF Lot 8', 'MCF2 Lot 1', 'MCF2 Lot 2', 'MCF2 Lot 3', 'MCF2 Lot 4', 'MCF3 Lot 1', 'MCF3 Lot 2', 'MCF3 Lot 3', 'MCF3 Lot 4', 'MCF3 Lot 5', 'MCF3 Lot 6', 'MCF3 Lot 7', 'MCF3 Lot 8', 'MCF3 Lot 9'] } }
      let(:supplier_service_offerings_file_options) { { sheets: ['MCF Lot 2', 'MCF Lot 3', 'MCF Lot 4', 'MCF Lot 5', 'MCF Lot 6', 'MCF Lot 7', 'MCF Lot 8', 'MCF2 Lot 1', 'MCF2 Lot 2', 'MCF2 Lot 3', 'MCF2 Lot 4', 'MCF3 Lot 1', 'MCF3 Lot 2', 'MCF3 Lot 3', 'MCF3 Lot 4', 'MCF3 Lot 5', 'MCF3 Lot 6', 'MCF3 Lot 7', 'MCF3 Lot 8', 'MCF3 Lot 9'] } }

      it 'changes the state to failed and has the correct errors' do
        expect(upload).to have_state(:failed)
        expect(upload.import_errors).to eq [{ error: 'supplier_details_missing_sheets' },
                                            { error: 'supplier_rate_cards_missing_sheets' },
                                            { error: 'supplier_service_offerings_missing_sheets' }]
      end
    end

    context 'when the files have the wrong headers and columns' do
      let(:supplier_details_file_options) { { headers: ManagementConsultancy::RM6187::SupplierDetailsFile.sheets_with_extra_headers(['MCF3']) } }
      let(:supplier_rate_cards_file_options) { { headers: ManagementConsultancy::RM6187::SupplierRateCardsFile.sheets_with_extra_headers(['MCF3 Lot 3', 'MCF3 Lot 4']) } }
      let(:supplier_service_offerings_file_options) { { headers: ManagementConsultancy::RM6187::SupplierServiceOfferingsFile.headers_with_extra_service(['MCF3 Lot 2', 'MCF3 Lot 4', 'MCF3 Lot 8']) } }

      it 'changes the state to failed and has the correct errors' do
        expect(upload).to have_state(:failed)
        expect(upload.import_errors).to eq [{ error: 'supplier_details_has_incorrect_headers', details: ['MCF3'] },
                                            { error: 'supplier_rate_cards_has_incorrect_headers', details: ['MCF3 Lot 3', 'MCF3 Lot 4'] },
                                            { error: 'supplier_service_offerings_has_incorrect_headers', details: ['MCF3 Lot 2', 'MCF3 Lot 4', 'MCF3 Lot 8'] }]
      end
    end

    context 'when the files are empty' do
      let(:supplier_details_file_options) { { empty: true } }
      let(:supplier_rate_cards_file_options) { { empty: true } }
      let(:supplier_service_offerings_file_options) { { empty: true } }

      it 'changes the state to failed and has the correct errors' do
        expect(upload).to have_state(:failed)
        expect(upload.import_errors).to eq [{ error: 'supplier_details_has_empty_sheets', details: ['MCF3'] },
                                            { error: 'supplier_rate_cards_has_empty_sheets', details: ['MCF3 Lot 1', 'MCF3 Lot 2', 'MCF3 Lot 3', 'MCF3 Lot 4', 'MCF3 Lot 5', 'MCF3 Lot 6', 'MCF3 Lot 7', 'MCF3 Lot 8', 'MCF3 Lot 9'] },
                                            { error: 'supplier_service_offerings_has_empty_sheets', details: ['MCF3 Lot 1', 'MCF3 Lot 2', 'MCF3 Lot 3', 'MCF3 Lot 4', 'MCF3 Lot 5', 'MCF3 Lot 6', 'MCF3 Lot 7', 'MCF3 Lot 8', 'MCF3 Lot 9'] }]
      end
    end
  end

  describe 'check_processed_data' do
    context 'when a supplier has no lots' do
      let(:supplier_service_offerings_file_options) { { supplier_duns: { 'REX LTD': '987654321' } } }

      it 'changes the state to failed and has the correct errors' do
        expect(upload).to have_state(:failed)
        expect(upload.import_errors).to eq [{ error: 'supplier_missing_services', details: ['REX LTD'] }]
      end
    end

    context 'when a supplier has no rate cards' do
      let(:supplier_rate_cards_file_options) { { supplier_duns: { 'MORAG JEWEL LTD': '987654321' } } }

      it 'changes the state to failed and has the correct errors' do
        expect(upload).to have_state(:failed)
        expect(upload.import_errors).to eq [{ error: 'supplier_missing_rates', details: ['MORAG JEWEL LTD'] }]
      end
    end
  end

  describe 'import_data' do
    let(:expected_supplier_results) do
      {
        'REX LTD': { lots: 9, services: 131, jurisdictions: 9, rates: 54 },
        'MORAG JEWEL LTD': { lots: 9, services: 131, jurisdictions: 9, rates: 54 },
        'ZEKE VON GEMBU CORP': { lots: 9, services: 131, jurisdictions: 9, rates: 54 },
      }
    end

    it 'publishes the data and all the suppliers are imported' do
      expect(upload).to have_state(:published)
      expect(Supplier::Framework.where(framework_id: 'RM6187').count).to eq 3
    end

    # rubocop:disable RSpec/MultipleExpectations
    it 'has the correct data for the suppliers' do
      expected_supplier_results.each do |name, expected_results|
        supplier_framework = Supplier.find_by(name:).supplier_frameworks.find_by(framework_id: 'RM6187')

        expect(supplier_framework.lots.count).to eq expected_results[:lots]
        expect(supplier_framework.lots.sum { |lot| lot.services.count }).to eq expected_results[:services]
        expect(supplier_framework.lots.sum { |lot| lot.jurisdictions.count }).to eq expected_results[:jurisdictions]
        expect(supplier_framework.lots.sum { |lot| lot.rates.count }).to eq expected_results[:rates]
      end
    end
    # rubocop:enable RSpec/MultipleExpectations
  end
end

require 'rails_helper'

RSpec.describe ManagementConsultancy::FilesImporter do
  let(:upload) do
    create(:management_consultancy_admin_upload, aasm_state: 'in_progress') do |admin_upload|
      admin_upload.supplier_details_file.attach(io: File.open(supplier_details_file_path), filename: 'test_supplier_details_file.xlsx')
      admin_upload.supplier_rate_cards_file.attach(io: File.open(supplier_rate_cards_file_path), filename: 'test_supplier_rate_cards_file.xlsx')
      admin_upload.supplier_regional_offerings_file.attach(io: File.open(supplier_regional_offerings_file_path), filename: 'test_supplier_regional_offerings_file.xlsx')
      admin_upload.supplier_service_offerings_file.attach(io: File.open(supplier_service_offerings_file_path), filename: 'test_supplier_service_offerings_file.xlsx')
    end
  end

  let(:supplier_details_file) { ManagementConsultancy::Legacy::SupplierDetailsFile.new(**supplier_details_file_options) }
  let(:supplier_details_file_path) { ManagementConsultancy::Legacy::SupplierDetailsFile::OUTPUT_PATH }
  let(:supplier_details_file_options) { {} }

  let(:supplier_rate_cards_file) { ManagementConsultancy::Legacy::SupplierRateCardsFile.new(**supplier_rate_cards_file_options) }
  let(:supplier_rate_cards_file_path) { ManagementConsultancy::Legacy::SupplierRateCardsFile::OUTPUT_PATH }
  let(:supplier_rate_cards_file_options) { {} }

  let(:supplier_regional_offerings_file) { ManagementConsultancy::Legacy::SupplierRegionalOfferingsFile.new(**supplier_regional_offerings_file_options) }
  let(:supplier_regional_offerings_file_path) { ManagementConsultancy::Legacy::SupplierRegionalOfferingsFile::OUTPUT_PATH }
  let(:supplier_regional_offerings_file_options) { {} }

  let(:supplier_service_offerings_file) { ManagementConsultancy::Legacy::SupplierServiceOfferingsFile.new(**supplier_service_offerings_file_options) }
  let(:supplier_service_offerings_file_path) { ManagementConsultancy::Legacy::SupplierServiceOfferingsFile::OUTPUT_PATH }
  let(:supplier_service_offerings_file_options) { {} }

  let(:files_importer) { described_class.new(upload) }

  before do
    allow(Marketplace).to receive(:mcf3_live?).and_return(false)
    supplier_details_file.build
    supplier_details_file.write
    supplier_rate_cards_file.build
    supplier_rate_cards_file.write
    supplier_regional_offerings_file.build
    supplier_regional_offerings_file.write
    supplier_service_offerings_file.build
    supplier_service_offerings_file.write

    files_importer.import_data
  end

  describe 'check_files' do
    context 'when the files have the wrong sheets' do
      let(:supplier_details_file_options) { { sheets: ['MCF', 'MCF2'] } }
      let(:supplier_rate_cards_file_options) { { sheets: ['MCF Lot 2', 'MCF Lot 3', 'MCF Lot 4', 'MCF Lot 5', 'MCF Lot 6', 'MCF Lot 7', 'MCF Lot 8', 'MCF2 Lot 1', 'MCF2 Lot 2', 'MCF2 Lot 3', 'MCF2 Lot 4', 'MCF3 Lot 1', 'MCF3 Lot 2', 'MCF3 Lot 3', 'MCF3 Lot 4', 'MCF3 Lot 6', 'MCF3 Lot 7', 'MCF3 Lot 8', 'MCF3 Lot 9'] } }
      let(:supplier_regional_offerings_file_options) { { sheets: ['MCF Lot 2', 'MCF Lot 3', 'MCF Lot 5', 'MCF Lot 6', 'MCF Lot 7', 'MCF Lot 8', 'MCF2 Lot 1', 'MCF2 Lot 2', 'MCF2 Lot 3', 'MCF2 Lot 4'] } }
      let(:supplier_service_offerings_file_options) { { sheets: ['MCF Lot 2', 'MCF Lot 3', 'MCF Lot 4', 'MCF Lot 5', 'MCF Lot 6', 'MCF Lot 7', 'MCF Lot 8', 'MCF2 Lot 2', 'MCF2 Lot 3', 'MCF2 Lot 4', 'MCF3 Lot 1', 'MCF3 Lot 2', 'MCF3 Lot 3', 'MCF3 Lot 4', 'MCF3 Lot 6', 'MCF3 Lot 7', 'MCF3 Lot 8', 'MCF3 Lot 9'] } }

      it 'changes the state to failed and has the correct errors' do
        expect(upload).to have_state(:failed)
        expect(upload.import_errors).to eq [{ error: 'supplier_details_missing_sheets' },
                                            { error: 'supplier_rate_cards_missing_sheets' },
                                            { error: 'supplier_regional_offerings_missing_sheets' },
                                            { error: 'supplier_service_offerings_missing_sheets' }]
      end
    end

    context 'when the files have the wrong headers and columns' do
      let(:supplier_details_file_options) { { headers: ManagementConsultancy::Legacy::SupplierDetailsFile.sheets_with_extra_headers(['MCF']) } }
      let(:supplier_rate_cards_file_options) { { headers: ManagementConsultancy::Legacy::SupplierRateCardsFile.sheets_with_extra_headers(['MCF Lot 3', 'MCF2 Lot 4']) } }
      let(:supplier_regional_offerings_file_options) { { headers: ManagementConsultancy::Legacy::SupplierRegionalOfferingsFile.sheets_with_extra_headers(['MCF Lot 4', 'MCF2 Lot 3']) } }
      let(:supplier_service_offerings_file_options) { { headers: ManagementConsultancy::Legacy::SupplierServiceOfferingsFile.headers_with_extra_service(['MCF Lot 8', 'MCF2 Lot 2', 'MCF3 Lot 4']) } }

      it 'changes the state to failed and has the correct errors' do
        expect(upload).to have_state(:failed)
        expect(upload.import_errors).to eq [{ error: 'supplier_details_headers_incorrect', details: ['MCF'] },
                                            { error: 'supplier_rate_cards_missing_column', details: ['MCF Lot 3', 'MCF2 Lot 4'] },
                                            { error: 'supplier_regional_offerings_headers_incorrect', details: ['MCF Lot 4', 'MCF2 Lot 3'] },
                                            { error: 'supplier_service_offering_missing_rows', details: ['MCF Lot 8', 'MCF2 Lot 2', 'MCF3 Lot 4'] }]
      end
    end
  end

  describe 'check_processed_data' do
    context 'when a supplier has no lots' do
      let(:supplier_service_offerings_file_options) { { supplier_duns: { 'NIA CORP': '987654321' } } }

      it 'changes the state to failed and has the correct errors' do
        expect(upload).to have_state(:failed)
        expect(upload.import_errors).to eq [{ error: 'supplier_missing_lots', details: ['NIA CORP'] }]
      end
    end

    context 'when a supplier has no rate cards' do
      let(:supplier_rate_cards_file_options) { { supplier_duns: { 'VANDHAM EXEC CORP': '987654321' } } }

      it 'changes the state to failed and has the correct errors' do
        expect(upload).to have_state(:failed)
        expect(upload.import_errors).to eq [{ error: 'supplier_missing_rate_cards', details: ['VANDHAM EXEC CORP'] }]
      end
    end
  end

  describe 'import_data' do
    let(:expected_supplier_results) do
      {
        'REX LTD': { regional_availabilities: 217, service_offerings: 292, rate_cards: 16 },
        'NIA CORP': { regional_availabilities: 203, service_offerings: 161, rate_cards: 7 },
        'TORA LTD': { regional_availabilities: 308, service_offerings: 330, rate_cards: 11 },
        'VANDHAM EXEC CORP': { regional_availabilities: 104, service_offerings: 169, rate_cards: 4 },
        'MORAG JEWEL LTD': { regional_availabilities: 124, service_offerings: 300, rate_cards: 13 },
        'ZEKE VON GEMBU CORP': { regional_availabilities: 0, service_offerings: 131, rate_cards: 9 }
      }
    end

    it 'publishes the data and all the suppliers are imported' do
      expect(upload).to have_state(:published)
      expect(ManagementConsultancy::Supplier.count).to eq 6
    end

    it 'has the correct data for the suppliers' do
      expected_supplier_results.each do |name, expected_results|
        supplier = ManagementConsultancy::Supplier.find_by(name: name)

        expect(supplier.regional_availabilities.count).to eq expected_results[:regional_availabilities]
        expect(supplier.service_offerings.count).to eq expected_results[:service_offerings]
        expect(supplier.rate_cards.count).to eq expected_results[:rate_cards]
      end
    end
  end
end

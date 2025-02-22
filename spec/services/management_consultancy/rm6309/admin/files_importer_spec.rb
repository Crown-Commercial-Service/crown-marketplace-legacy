require 'rails_helper'

RSpec.describe ManagementConsultancy::RM6309::Admin::FilesImporter do
  let(:upload) do
    create(:management_consultancy_rm6309_admin_upload, aasm_state: 'in_progress') do |admin_upload|
      admin_upload.supplier_details_file.attach(io: File.open(supplier_details_file_path), filename: 'test_supplier_details_file.xlsx')
      admin_upload.supplier_rate_cards_file.attach(io: File.open(supplier_rate_cards_file_path), filename: 'test_supplier_rate_cards_file.xlsx')
      admin_upload.supplier_service_offerings_file.attach(io: File.open(supplier_service_offerings_file_path), filename: 'test_supplier_service_offerings_file.xlsx')
    end
  end

  let(:supplier_details_file) { ManagementConsultancy::RM6309::SupplierDetailsFile.new(**supplier_details_file_options) }
  let(:supplier_details_file_path) { ManagementConsultancy::RM6309::SupplierDetailsFile::OUTPUT_PATH }
  let(:supplier_details_file_options) { {} }

  let(:supplier_rate_cards_file) { ManagementConsultancy::RM6309::SupplierRateCardsFile.new(**supplier_rate_cards_file_options) }
  let(:supplier_rate_cards_file_path) { ManagementConsultancy::RM6309::SupplierRateCardsFile::OUTPUT_PATH }
  let(:supplier_rate_cards_file_options) { {} }

  let(:supplier_service_offerings_file) { ManagementConsultancy::RM6309::SupplierServiceOfferingsFile.new(**supplier_service_offerings_file_options) }
  let(:supplier_service_offerings_file_path) { ManagementConsultancy::RM6309::SupplierServiceOfferingsFile::OUTPUT_PATH }
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
      let(:supplier_details_file_options) { { sheets: ['MCF2', 'MCF3', 'MCF4'] } }
      let(:supplier_rate_cards_file_options) { { sheets: ['MCF2 Lot 2', 'MCF2 Lot 3', 'MCF2 Lot 4', 'MCF2 Lot 5', 'MCF2 Lot 6', 'MCF2 Lot 7', 'MCF2 Lot 8', 'MCF3 Lot 1', 'MCF3 Lot 2', 'MCF3 Lot 3', 'MCF3 Lot 4', 'MCF4 Lot 1', 'MCF4 Lot 2', 'MCF4 Lot 3', 'MCF4 Lot 4', 'MCF4 Lot 5', 'MCF4 Lot 6', 'MCF4 Lot 7', 'MCF4 Lot 8', 'MCF4 Lot 9'] } }
      let(:supplier_service_offerings_file_options) { { sheets: ['MCF2 Lot 2', 'MCF2 Lot 3', 'MCF2 Lot 4', 'MCF2 Lot 5', 'MCF2 Lot 6', 'MCF2 Lot 7', 'MCF2 Lot 8', 'MCF3 Lot 1', 'MCF3 Lot 2', 'MCF3 Lot 3', 'MCF3 Lot 4', 'MCF4 Lot 1', 'MCF4 Lot 2', 'MCF4 Lot 3', 'MCF4 Lot 4', 'MCF4 Lot 5', 'MCF4 Lot 6', 'MCF4 Lot 7', 'MCF4 Lot 8', 'MCF4 Lot 9'] } }

      it 'changes the state to failed and has the correct errors' do
        expect(upload).to have_state(:failed)
        expect(upload.import_errors).to eq [{ error: 'supplier_details_missing_sheets' },
                                            { error: 'supplier_rate_cards_missing_sheets' },
                                            { error: 'supplier_service_offerings_missing_sheets' }]
      end
    end

    context 'when the files have the wrong headers and columns' do
      let(:supplier_details_file_options) { { headers: ManagementConsultancy::RM6309::SupplierDetailsFile.sheets_with_extra_headers(['MCF4']) } }
      let(:supplier_rate_cards_file_options) { { headers: ManagementConsultancy::RM6309::SupplierRateCardsFile.sheets_with_extra_headers(['MCF4 Lot 3', 'MCF4 Lot 10']) } }
      let(:supplier_service_offerings_file_options) { { headers: ManagementConsultancy::RM6309::SupplierServiceOfferingsFile.headers_with_extra_service(['MCF4 Lot 2', 'MCF4 Lot 4', 'MCF4 Lot 8']) } }

      it 'changes the state to failed and has the correct errors' do
        expect(upload).to have_state(:failed)
        expect(upload.import_errors).to eq [{ error: 'supplier_details_has_incorrect_headers', details: ['MCF4'] },
                                            { error: 'supplier_rate_cards_has_incorrect_headers', details: ['MCF4 Lot 3', 'MCF4 Lot 10'] },
                                            { error: 'supplier_service_offerings_has_incorrect_headers', details: ['MCF4 Lot 2', 'MCF4 Lot 4', 'MCF4 Lot 8'] }]
      end
    end

    context 'when the files are empty' do
      let(:supplier_details_file_options) { { empty: true } }
      let(:supplier_rate_cards_file_options) { { empty: true } }
      let(:supplier_service_offerings_file_options) { { empty: true } }

      it 'changes the state to failed and has the correct errors' do
        expect(upload).to have_state(:failed)
        expect(upload.import_errors).to eq [{ error: 'supplier_details_has_empty_sheets', details: ['MCF4'] },
                                            { error: 'supplier_rate_cards_has_empty_sheets', details: ['MCF4 Lot 1', 'MCF4 Lot 2', 'MCF4 Lot 3', 'MCF4 Lot 4', 'MCF4 Lot 5', 'MCF4 Lot 6', 'MCF4 Lot 7', 'MCF4 Lot 8', 'MCF4 Lot 9', 'MCF4 Lot 10'] },
                                            { error: 'supplier_service_offerings_has_empty_sheets', details: ['MCF4 Lot 1', 'MCF4 Lot 2', 'MCF4 Lot 3', 'MCF4 Lot 4', 'MCF4 Lot 5', 'MCF4 Lot 6', 'MCF4 Lot 7', 'MCF4 Lot 8', 'MCF4 Lot 9', 'MCF4 Lot 10'] }]
      end
    end
  end

  describe 'check_processed_data' do
    context 'when a supplier has no lots' do
      let(:supplier_service_offerings_file_options) { { supplier_duns: { 'REX LTD': '987654321' } } }

      it 'changes the state to failed and has the correct errors' do
        expect(upload).to have_state(:failed)
        expect(upload.import_errors).to eq [{ error: 'supplier_missing_lots', details: ['REX LTD'] }]
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
        'REX LTD': { service_offerings: 135, rate_cards: 20, lot_contact_details: 10 },
        'MORAG JEWEL LTD': { service_offerings: 135, rate_cards: 20, lot_contact_details: 10 },
        'ZEKE VON GEMBU CORP': { service_offerings: 135, rate_cards: 20, lot_contact_details: 10 }
      }
    end

    it 'publishes the data and all the suppliers are imported' do
      expect(upload).to have_state(:published)
      expect(ManagementConsultancy::RM6309::Supplier.count).to eq 3
    end

    it 'has the correct data for the suppliers' do
      expected_supplier_results.each do |name, expected_results|
        supplier = ManagementConsultancy::RM6309::Supplier.find_by(name:)

        expect(supplier.service_offerings.count).to eq expected_results[:service_offerings]
        expect(supplier.rate_cards.count).to eq expected_results[:rate_cards]
        expect(supplier.lot_contact_details.count).to eq expected_results[:lot_contact_details]
      end
    end
  end
end

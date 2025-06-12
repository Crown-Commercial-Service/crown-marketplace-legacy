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
        'REX LTD': { service_offerings: 161, rate_cards: 20 },
        'MORAG JEWEL LTD': { service_offerings: 161, rate_cards: 20 },
        'ZEKE VON GEMBU CORP': { service_offerings: 161, rate_cards: 20 }
      }
    end

    it 'publishes the data and all the suppliers are imported' do
      expect(upload).to have_state(:published)
      expect(ManagementConsultancy::RM6309::Supplier.count).to eq 3
    end

    it 'has the correct counts for the suppliers' do
      expected_supplier_results.each do |name, expected_results|
        supplier = ManagementConsultancy::RM6309::Supplier.find_by(name:)

        expect(supplier.service_offerings.count).to eq expected_results[:service_offerings]
        expect(supplier.rate_cards.count).to eq expected_results[:rate_cards]
      end
    end

    context 'when considering the data for a supplier' do
      let(:supplier) { ManagementConsultancy::RM6309::Supplier.find_by(name: 'REX LTD') }

      it 'has the correct supplier details' do
        expect(supplier.attributes.slice(*%w[name contact_name contact_email telephone_number sme address website duns])).to eq({
                                                                                                                                  'name' => 'REX LTD',
                                                                                                                                  'contact_name' => 'REX',
                                                                                                                                  'contact_email' => 'rex@xenoblade.com',
                                                                                                                                  'telephone_number' => '0202 123 4567',
                                                                                                                                  'sme' => true,
                                                                                                                                  'address' => 'Argentum AA3 1XC',
                                                                                                                                  'website' => 'www.rex.com',
                                                                                                                                  'duns' => 123456789
                                                                                                                                })
      end

      it 'has the correct rate card data for lot 1' do
        advice_rate = supplier.rate_cards.find_by(lot: 'MCF4.1', rate_type: 'Advice')
        delivery_rate = supplier.rate_cards.find_by(lot: 'MCF4.1', rate_type: 'Delivery')

        advice_rates = []
        delivery_rates = []

        %i[junior_rate_in_pence standard_rate_in_pence senior_rate_in_pence principal_rate_in_pence managing_rate_in_pence director_rate_in_pence].each do |rate_type|
          advice_rates << advice_rate[rate_type]
          delivery_rates << delivery_rate[rate_type]
        end

        expect(advice_rates).to eq([40000, 80000, 120000, 160000, 200000, 240000])
        expect(delivery_rates).to eq([45000, 85000, 125000, 165000, 205000, 245000])
      end

      it 'has the correct rate card data for lot 10' do
        complex_rate = supplier.rate_cards.find_by(lot: 'MCF4.10', rate_type: 'Complex')
        non_complex_rate = supplier.rate_cards.find_by(lot: 'MCF4.10', rate_type: 'Non-Complex')

        complex_rates = []
        non_complex_rates = []

        %i[junior_rate_in_pence standard_rate_in_pence senior_rate_in_pence principal_rate_in_pence managing_rate_in_pence director_rate_in_pence].each do |rate_type|
          complex_rates << complex_rate[rate_type]
          non_complex_rates << non_complex_rate[rate_type]
        end

        expect(complex_rates).to eq([40000, 80000, 120000, 160000, 200000, 240000])
        expect(non_complex_rates).to eq([45000, 85000, 125000, 165000, 205000, 245000])
      end
    end
  end
end

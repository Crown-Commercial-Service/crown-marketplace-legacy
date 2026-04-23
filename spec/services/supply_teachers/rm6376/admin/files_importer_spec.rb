require 'rails_helper'

module SupplyTeachers::RM6376::Admin
  RSpec.describe FilesImporter do
    let(:upload) do
      create(:supply_teachers_rm6376_admin_upload, aasm_state: 'in_progress') do |admin_upload|
        File.open(supplier_details_file_path, 'rb') do |file_stream|
          admin_upload.supplier_details_file.attach(io: file_stream, filename: 'test_supplier_details_file.xlsx')
        end
        File.open(supplier_geographical_data_file_path, 'rb') do |file_stream|
          admin_upload.supplier_geographical_data_file.attach(io: file_stream, filename: 'test_supplier_geographical_data_file.xlsx')
        end
        File.open(supplier_rate_cards_file_path, 'rb') do |file_stream|
          admin_upload.supplier_rate_cards_file.attach(io: file_stream, filename: 'test_supplier_rate_cards_file.xlsx')
        end
      end
    end

    let(:supplier_details_file) { SupplierDetailsFile.new(**supplier_details_file_options) }
    let(:supplier_details_file_path) { SupplierDetailsFile::OUTPUT_PATH }
    let(:supplier_details_file_options) { {} }

    let(:supplier_geographical_data_file) { SupplierGeographicalDataFile.new(**supplier_geographical_data_file_options) }
    let(:supplier_geographical_data_file_path) { SupplierGeographicalDataFile::OUTPUT_PATH }
    let(:supplier_geographical_data_file_options) { {} }

    let(:supplier_rate_cards_file) { SupplierRateCardsFile.new(**supplier_rate_cards_file_options) }
    let(:supplier_rate_cards_file_path) { SupplierRateCardsFile::OUTPUT_PATH }
    let(:supplier_rate_cards_file_options) { {} }

    let(:files_importer) { described_class.new(upload) }

    before do
      Geocoder::Lookup::Test.set_default_stub([{ 'coordinates' => [nil, nil] }])

      [
        ['TW2 7BA', [{ 'coordinates' => [51.46190833253159, -0.340934872716188] }]],
        ['L4 0TH', [{ 'coordinates' => [53.43134641218853, -2.960931536892127] }]],
        ['B2 4BJ', [{ 'coordinates' => [52.4789997328729, -1.9007014905137978] }]],
        ['E20 2ST', [{ 'coordinates' => [51.53856612802023, -0.016517049198377255] }]],
        ['DY1 4AL', [{ 'coordinates' => [52.524659858134505, -2.047541022496625] }]],
      ].each do |postcode, location|
        Geocoder::Lookup::Test.add_stub(postcode, location)
      end

      Upload::ATTRIBUTES.each do |file|
        send(file).build
        send(file).write
      end

      files_importer.import_data
    end

    after do
      Geocoder::Lookup::Test.reset
    end

    describe 'check_files' do
      context 'when the files have the wrong sheets' do
        let(:supplier_details_file_options) { { sheets: ['All regions'] } }
        let(:supplier_geographical_data_file_options) { { sheets: ['Lot 1', 'Lot 2'] } }
        let(:supplier_rate_cards_file_options) { { sheets: ['Lot 1', 'Lot 2a', 'Lot 2b'] } }

        it 'changes the state to failed and has the correct errors' do
          expect(upload).to have_state(:failed)
          expect(upload.import_errors).to eq [{ error: 'supplier_details_missing_sheets' },
                                              { error: 'supplier_geographical_data_missing_sheets' },
                                              { error: 'supplier_rate_cards_missing_sheets' },]
        end
      end

      context 'when the files have the wrong headers and columns' do
        let(:supplier_details_file_options) { { headers: SupplierDetailsFile.sheets_with_extra_headers(['All Suppliers']) } }
        let(:supplier_geographical_data_file_options) { { headers: SupplierGeographicalDataFile.sheets_with_extra_headers(['Branch details']) } }
        let(:supplier_rate_cards_file_options) { { headers: SupplierRateCardsFile.sheets_with_extra_headers(['Lot 2']) } }

        it 'changes the state to failed and has the correct errors' do
          expect(upload).to have_state(:failed)
          expect(upload.import_errors).to eq [{ error: 'supplier_details_has_incorrect_headers' },
                                              { error: 'supplier_geographical_data_has_incorrect_headers' },
                                              { error: 'supplier_rate_cards_has_incorrect_headers', details: ['Lot 2'] },]
        end
      end

      context 'when the files are empty' do
        let(:supplier_details_file_options) { { empty: true } }
        let(:supplier_geographical_data_file_options) { { empty: true } }
        let(:supplier_rate_cards_file_options) { { empty: true } }

        it 'changes the state to failed and has the correct errors' do
          expect(upload).to have_state(:failed)
          expect(upload.import_errors).to eq [{ error: 'supplier_details_has_empty_sheets' },
                                              { error: 'supplier_geographical_data_has_empty_sheets' },
                                              { error: 'supplier_rate_cards_has_empty_sheets', details: ['Lot 1', 'Lot 2',] }]
        end
      end
    end

    describe 'check_processed_data' do
      # no lots
      # no rates
      # No branches
      # no branch data
      context 'when a supplier has no lots' do
        let(:supplier_details_file_options) { { supplier_no_lots: ['561234'] } }

        it 'changes the state to failed and has the correct errors' do
          expect(upload).to have_state(:failed)
          expect(upload.import_errors).to eq [{ error: 'supplier_missing_lots', details: ['ETHEL LTD'] }]
        end
      end

      context 'when a supplier has no branches' do
        let(:supplier_geographical_data_file_options) { { supplier_no_branches: ['234561'] } }

        it 'changes the state to failed and has the correct errors' do
          expect(upload).to have_state(:failed)
          expect(upload.import_errors).to eq [{ error: 'supplier_missing_branches', details: ['MIO CORP'] }]
        end
      end

      context 'when a supplier has no branch data' do
        let(:supplier_geographical_data_file_options) { { supplier_no_branch_data: ['345612'] } }

        it 'changes the state to failed and has the correct errors' do
          expect(upload).to have_state(:failed)
          expect(upload.import_errors).to eq [{ error: 'supplier_missing_branch_data', details: ['REKU LTD'] }]
        end
      end

      context 'when a supplier has no rate cards' do
        let(:supplier_rate_cards_file_options) { { supplier_no_rates: ['456123'] } }

        it 'changes the state to failed and has the correct errors' do
          expect(upload).to have_state(:failed)
          expect(upload.import_errors).to eq [{ error: 'supplier_missing_rates', details: ['GUERNICA EXEC CORP'] }]
        end
      end
    end

    describe 'import_data' do
      let(:expected_supplier_results) do
        {
          'NOAH LTD': { lots: 1, services: 0, branches: 2, jurisdictions: 1, rates: 11 },
          'MIO CORP': { lots: 1, services: 0, branches: 2, jurisdictions: 1, rates: 11 },
          'REKU LTD': { lots: 2, services: 0, branches: 2, jurisdictions: 2, rates: 22 },
          'GUERNICA EXEC CORP': { lots: 1, services: 0, branches: 0, jurisdictions: 1, rates: 11 },
          'ETHEL LTD': { lots: 1, services: 0, branches: 0, jurisdictions: 1, rates: 11 },
        }
      end

      it 'publishes the data and all the suppliers are imported' do
        expect(upload).to have_state(:published)
        expect(Supplier::Framework.where(framework_id: 'RM6376').count).to eq 5
      end

      # rubocop:disable RSpec/MultipleExpectations
      it 'has the correct data for the suppliers' do
        expected_supplier_results.each do |name, expected_results|
          supplier_framework = Supplier.find_by(name:).supplier_frameworks.find_by(framework_id: 'RM6376')

          expect(supplier_framework.lots.count).to eq expected_results[:lots]
          expect(supplier_framework.lots.sum { |lot| lot.services.count }).to eq expected_results[:services]
          expect(supplier_framework.lots.sum { |lot| lot.branches.count }).to eq expected_results[:branches]
          expect(supplier_framework.lots.sum { |lot| lot.jurisdictions.count }).to eq expected_results[:jurisdictions]
          expect(supplier_framework.lots.sum { |lot| lot.rates.count }).to eq expected_results[:rates]
        end
      end
      # rubocop:enable RSpec/MultipleExpectations
    end
  end
end

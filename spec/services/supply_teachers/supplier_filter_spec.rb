require 'rails_helper'

RSpec.describe SupplyTeachers::SupplierFilter do
  subject(:supplier_filter) { described_class.new(lot_id:, agency_name:, agency_postcode:) }

  let(:lot_id) { 'RM6376.1' }
  let(:agency_name) { '' }
  let(:agency_postcode) { '' }

  before do
    if agency_postcode.present?
      Geocoder::Lookup::Test.add_stub(
        agency_postcode, [{ 'coordinates' => [51.5149666, -0.119098] }]
      )
    end
  end

  after do
    Geocoder::Lookup::Test.reset
  end

  describe 'validations' do
    context 'when the agency name and agency postcode are blank' do
      it 'is valid' do
        expect(supplier_filter).to be_valid
      end
    end

    context 'when the agency name and agency postcode have values' do
      let(:agency_name) { 'Michael Schofield' }
      let(:agency_postcode) { 'L3 9PP' }

      it 'is valid' do
        expect(supplier_filter).to be_valid
      end
    end

    context 'when the postcode is invalid' do
      let(:agency_postcode) { 'Invalid postcode' }

      it 'is not valid' do
        expect(supplier_filter).not_to be_valid
        expect(supplier_filter.errors[:agency_postcode].first).to eq('Enter a valid postcode')
      end
    end

    context 'when the postcode is not found' do
      let(:agency_postcode) { 'L3 9PP' }

      before do
        Geocoder::Lookup::Test.add_stub(
          agency_postcode, [{ 'coordinates' => nil }]
        )
      end

      it 'is not valid' do
        expect(supplier_filter).not_to be_valid
        expect(supplier_filter.errors[:agency_postcode].first).to eq('Enter a valid postcode')
      end
    end
  end

  describe 'filter_suppliers_query' do
    let(:result) { supplier_filter.filter_suppliers_query.sort_by(&:supplier_name).map(&:supplier_name) }

    before do
      supplier_framework_1 = create(:supplier_framework, framework_id: 'RM6238', supplier: create(:supplier, name: 'aaa'))
      supplier_framework_2 = create(:supplier_framework, framework_id: 'RM6238', supplier: create(:supplier, name: 'aab'))
      supplier_framework_3 = create(:supplier_framework, framework_id: 'RM6238', supplier: create(:supplier, name: 'zzy'))
      supplier_framework_4 = create(:supplier_framework, framework_id: 'RM6238', supplier: create(:supplier, name: 'zzz'))

      supplier_framework_lot_1 = create(:supplier_framework_lot, supplier_framework: supplier_framework_1, lot_id: lot_id)
      supplier_framework_lot_2 = create(:supplier_framework_lot, supplier_framework: supplier_framework_2, lot_id: lot_id)
      supplier_framework_lot_3 = create(:supplier_framework_lot, supplier_framework: supplier_framework_3, lot_id: lot_id)
      supplier_framework_lot_4 = create(:supplier_framework_lot, supplier_framework: supplier_framework_4, lot_id: lot_id)

      create(:supplier_framework_lot_rate, supplier_framework_lot: supplier_framework_lot_1, position_id: 'RM6238.1')
      create(:supplier_framework_lot_rate, supplier_framework_lot: supplier_framework_lot_2, position_id: 'RM6238.1')
      create(:supplier_framework_lot_rate, supplier_framework_lot: supplier_framework_lot_3, position_id: 'RM6238.1')
      create(:supplier_framework_lot_rate, supplier_framework_lot: supplier_framework_lot_4, position_id: 'RM6238.1')

      create(:supplier_framework_lot_branch, supplier_framework_lot: supplier_framework_lot_1, location: Geocoding.point(latitude: 51.5201, longitude: -0.0759))
      create(:supplier_framework_lot_branch, supplier_framework_lot: supplier_framework_lot_2, location: Geocoding.point(latitude: 55.9619, longitude: -3.1953))
      create(:supplier_framework_lot_branch, supplier_framework_lot: supplier_framework_lot_3, location: Geocoding.point(latitude: 55.9619, longitude: -3.1953))
      create(:supplier_framework_lot_branch, supplier_framework_lot: supplier_framework_lot_4, location: Geocoding.point(latitude: 51.5201, longitude: -0.0759))

      Geocoder::Lookup::Test.add_stub(
        agency_postcode, [{ 'coordinates' => [51.5201, -0.0759] }]
      )
    end

    after do
      Geocoder::Lookup::Test.reset
    end

    context 'when nothing is searched' do
      let(:agency_name) { nil }
      let(:agency_postcode) { nil }

      it 'has all suppliers in the list' do
        expect(result).to contain_exactly('aaa', 'aab', 'zzy', 'zzz')
      end

      context 'when a london postocode is searched' do
        let(:agency_postcode) { 'SW1A 1AA' }

        it 'has only the london suppliers in the list' do
          expect(result).to contain_exactly('aaa', 'zzz')
        end
      end
    end

    context 'when "a" is searched' do
      let(:agency_name) { 'a' }
      let(:agency_postcode) { nil }

      it 'has just aaa and aab in the list' do
        expect(result).to contain_exactly('aaa', 'aab')
      end

      context 'when a london postocode is searched' do
        let(:agency_postcode) { 'SW1A 1AA' }

        it 'has only the london supplier in the list' do
          expect(result).to contain_exactly('aaa')
        end
      end
    end

    context 'when "z" is searched' do
      let(:agency_name) { 'z' }
      let(:agency_postcode) { nil }

      it 'has just zzy and zzz in the list' do
        expect(result).to contain_exactly('zzy', 'zzz')
      end

      context 'when a london postocode is searched' do
        let(:agency_postcode) { 'SW1A 1AA' }

        it 'has only the london supplier in the list' do
          expect(result).to contain_exactly('zzz')
        end
      end
    end

    context 'when "l" is searched' do
      let(:agency_name) { 'l' }
      let(:agency_postcode) { nil }

      it 'has no suppliers in the list' do
        expect(result).to be_empty
      end

      context 'when a london postocode is searched' do
        let(:agency_postcode) { 'SW1A 1AA' }

        it 'has no suppliers in the list' do
          expect(result).to be_empty
        end
      end
    end
  end
end

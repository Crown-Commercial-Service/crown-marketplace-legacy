require 'rails_helper'

RSpec.describe Supplier::Framework::Lot::Rate do
  let(:supplier_framework_lot_rate) { create(:supplier_framework_lot_rate) }

  describe 'associations' do
    it { is_expected.to belong_to(:supplier_framework_lot) }
    it { is_expected.to belong_to(:position) }
    it { is_expected.to belong_to(:jurisdiction) }

    it 'has the supplier_framework_lot relationship' do
      expect(supplier_framework_lot_rate.supplier_framework_lot).to be_present
    end

    it 'has the position relationship' do
      expect(supplier_framework_lot_rate.position).to be_present
    end

    it 'has the jurisdiction relationship' do
      expect(supplier_framework_lot_rate.jurisdiction).to be_present
    end
  end

  describe 'uniqueness' do
    let(:supplier_framework_lot) { create(:supplier_framework_lot) }
    let(:position) { create(:position) }
    let(:jurisdiction) { create(:supplier_framework_lot_jurisdiction) }

    it 'raises an error if a record already exists for a supplier_framework_lot, position and jurisdiction' do
      create(:supplier_framework_lot_rate, supplier_framework_lot:, position:, jurisdiction:)

      expect { create(:supplier_framework_lot_rate, supplier_framework_lot:, position:, jurisdiction:) }.to raise_error(ActiveRecord::RecordNotUnique)
    end
  end

  describe '.normalized_rate' do
    before { supplier_framework_lot_rate.rate = rate }

    context 'and the rate is 3550' do
      let(:rate) { 3550 }

      it 'returns 35' do
        expect(supplier_framework_lot_rate.normalized_rate).to eq 35.5
      end
    end

    context 'and the rate is 1200' do
      let(:rate) { 1200 }

      it 'returns 12.0' do
        expect(supplier_framework_lot_rate.normalized_rate).to eq 12.0
      end
    end
  end

  describe '.rate_as_percentage_decimal' do
    before { supplier_framework_lot_rate.rate = rate }

    context 'and the rate is 3550' do
      let(:rate) { 3550 }

      it 'returns 35' do
        expect(supplier_framework_lot_rate.rate_as_percentage_decimal).to eq 0.355
      end
    end

    context 'and the rate is 1200' do
      let(:rate) { 1200 }

      it 'returns 12.0' do
        expect(supplier_framework_lot_rate.rate_as_percentage_decimal).to eq 0.12
      end
    end
  end

  # rubocop:disable RSpec/NestedGroups
  describe '.assign_rate_and_validate?' do
    let(:result) { supplier_framework_lot_rate.assign_rate_and_validate?(rate) }

    let(:rate_type) { 'money' }
    let(:mandatory) { true }
    let(:supplier_framework_lot_rate) { create(:supplier_framework_lot_rate, position: create(:position, rate_type:, mandatory:)) }

    context 'when the rate does not match the format for money' do
      [
        'I am not a number',
        true,
        '025.52',
        '.52',
        '96.this',
        'this.67',
        '58.9',
        '00.05',
        '0.5',
        '-52.98',
      ].each do |invalid_rate|
        context "and the rate is #{invalid_rate}" do
          let(:rate) { invalid_rate }

          it 'is invalid and sets the rate as nil' do
            expect(result).to be(false)
            expect(supplier_framework_lot_rate.rate).to be_nil
            expect(supplier_framework_lot_rate.errors[:rate].first).to eq('The rate must be formatted as money, for example £350.50')
          end
        end
      end
    end

    context 'when the rate does not match the format for percentage' do
      let(:rate_type) { 'percentage' }

      [
        'I am not a number',
        true,
        '025.52',
        '.52',
        '96.this',
        'this.67',
        '58.99',
        '00.5',
        '-52.98',
      ].each do |invalid_rate|
        context "and the rate is #{invalid_rate}" do
          let(:rate) { invalid_rate }

          it 'is invalid and sets the rate as nil' do
            expect(result).to be(false)
            expect(supplier_framework_lot_rate.rate).to be_nil
            expect(supplier_framework_lot_rate.errors[:rate].first).to eq('The rate must be formatted as a percentage, for example 50.5%')
          end
        end
      end
    end

    context 'when the rate is blank' do
      let(:rate) { '' }

      context 'and the rate is mandetory' do
        it 'is invalid' do
          expect(result).to be(false)
          expect(supplier_framework_lot_rate.errors[:rate].first).to eq('You must enter a value for this rate')
        end
      end

      context 'and the rate is not mandetory' do
        let(:mandatory) { false }

        it 'is valid and updates the rate' do
          expect(result).to be(true)
          expect(supplier_framework_lot_rate.rate).to be_nil
        end
      end
    end

    context 'when the rate type is money' do
      context 'and the rate is not less than 1,000,000' do
        let(:rate) { '1000000.00' }

        it 'is invalid' do
          expect(result).to be(false)
          expect(supplier_framework_lot_rate.errors[:rate].first).to eq('The rate must be less than £1,000,000')
        end
      end

      context 'and the rate is within range' do
        [
          ['0', 0],
          ['0.00', 0],
          ['350.50', 35050],
          ['350', 35000],
          ['56.05', 5605],
          ['999999.99', 99999999],
        ].each do |valid_rate, expected_rate|
          context "and the rate is #{valid_rate}" do
            let(:rate) { valid_rate }

            it 'is valid and updates the rate' do
              expect(result).to be(true)
              expect(supplier_framework_lot_rate.rate).to eq(expected_rate)
            end
          end
        end
      end
    end

    context 'when the rate type is percentage' do
      let(:rate_type) { 'percentage' }

      context 'and the rate is not less than 100' do
        let(:rate) { '100.0' }

        it 'is invalid' do
          expect(result).to be(false)
          expect(supplier_framework_lot_rate.errors[:rate].first).to eq('The rate must be less than 100%')
        end
      end

      context 'and the rate is within range' do
        [
          ['0', 0],
          ['0.0', 0],
          ['35.5', 3550],
          ['35', 3500],
          ['56.0', 5600],
          ['99.9', 9990],
        ].each do |valid_rate, expected_rate|
          context "and the rate is #{valid_rate}" do
            let(:rate) { valid_rate }

            it 'is valid and updates the rate' do
              expect(result).to be(true)
              expect(supplier_framework_lot_rate.rate).to eq(expected_rate)
            end
          end
        end
      end
    end
  end
  # rubocop:enable RSpec/NestedGroups
end

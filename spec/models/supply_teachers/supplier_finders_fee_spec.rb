require 'rails_helper'

RSpec.describe SupplyTeachers::SupplierFindersFee do
  let(:supplier_finders_fee) { described_class.new(fixed_term_length: fixed_term_length, salary: salary, fixed_term_rate: fixed_term_rate) }
  let(:fixed_term_rate) { 0.085 }
  let(:fixed_term_length) { 12 }

  describe '#finders_fee' do
    let(:result) { supplier_finders_fee.finders_fee }
    let(:salary) { '12345' }

    context 'when the fixed_term_length is greater than 12 months' do
      let(:fixed_term_length) { 18 }

      it 'does not use fixed_term_length in the caclulation' do
        expect(result).to eq 1049.325
      end
    end

    context 'when the fixed_term_length is less than 12 months' do
      let(:fixed_term_length) { 6 }

      it 'does use fixed_term_length in the caclulation' do
        expect(result).to eq 524.6625
      end
    end
  end

  describe 'valid?' do
    context 'when the salary does not resolve to an integer' do
      let(:salary) { '123f45' }

      it 'is not valid' do
        expect(supplier_finders_fee.valid?).to be false
      end
    end

    context 'when the salary is 0' do
      let(:salary) { '0' }

      it 'is not valid' do
        expect(supplier_finders_fee.valid?).to be false
      end
    end

    context 'when the salary is negative' do
      let(:salary) { '-78' }

      it 'is not valid' do
        expect(supplier_finders_fee.valid?).to be false
      end
    end

    context 'when the salary is greater than 0' do
      let(:salary) { '1' }

      it 'is valid' do
        expect(supplier_finders_fee.valid?).to be true
      end
    end

    context 'when the salary is a float' do
      let(:salary) { '1.5' }

      it 'is valid' do
        expect(supplier_finders_fee.valid?).to be true
      end
    end
  end
end

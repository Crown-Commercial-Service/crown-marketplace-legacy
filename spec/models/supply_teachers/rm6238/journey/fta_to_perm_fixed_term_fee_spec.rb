require 'rails_helper'

RSpec.describe SupplyTeachers::RM6238::Journey::FTAToPermFixedTermFee do
  subject(:step) do
    described_class.new(
      fixed_term_fee: fixed_term_fee,
      contract_start_date_day: '1',
      contract_start_date_month: '2',
      contract_start_date_year: '2022',
      contract_end_date_day: '1',
      contract_end_date_month: '3',
      contract_end_date_year: '2022'
    )
  end

  let(:fixed_term_fee) { '12334' }

  describe 'validations' do
    context 'when no fixed_term_fee is provided' do
      let(:fixed_term_fee) { '' }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:fixed_term_fee].first).to eq 'Enter the fixed term fee'
      end
    end

    context 'when no fixed_term_fee is not a number' do
      let(:fixed_term_fee) { 'I am not a number' }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:fixed_term_fee].first).to eq 'The fixed term fee must must be a number'
      end
    end

    context 'when no fixed_term_fee is less than 0' do
      let(:fixed_term_fee) { '-10' }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:fixed_term_fee].first).to eq 'The fixed term fee must be more than 0'
      end
    end

    context 'when an option that is in the list provided' do
      it 'is valid' do
        expect(step).to be_valid
      end
    end
  end

  describe '.next_step_class' do
    it 'returns Journey::FTAToPermFee' do
      expect(step.next_step_class).to be SupplyTeachers::RM6238::Journey::FTAToPermFee
    end
  end

  describe '.permit_list' do
    it 'returns a list of the permitted attributes' do
      expect(described_class.permit_list).to eq [:fixed_term_fee, :contract_start_date_day, :contract_start_date_month, :contract_start_date_year, :contract_end_date_day, :contract_end_date_month, :contract_end_date_year, {}]
    end
  end

  describe '.permitted_keys' do
    it 'returns a list of the permitted keys' do
      expect(described_class.permitted_keys).to eq %i[fixed_term_fee contract_start_date_day contract_start_date_month contract_start_date_year contract_end_date_day contract_end_date_month contract_end_date_year]
    end
  end

  describe '.slug' do
    it 'returns fta-to-perm-fixed-term-fee' do
      expect(step.slug).to eq 'fta-to-perm-fixed-term-fee'
    end
  end

  describe '.template' do
    it 'returns journey/fta_to_perm_fixed_term_fee' do
      expect(step.template).to eq 'journey/fta_to_perm_fixed_term_fee'
    end
  end

  describe '.all_keys_needed?' do
    it 'returns true' do
      expect(step.all_keys_needed?).to be true
    end
  end

  describe '.final?' do
    it 'returns false' do
      expect(step.final?).to be false
    end
  end
end

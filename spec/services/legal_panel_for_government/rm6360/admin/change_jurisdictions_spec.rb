require 'rails_helper'

RSpec.describe LegalPanelForGovernment::RM6360::Admin::ChangeJurisdictions do
  subject(:change_jurisdictions) { described_class.new(add_or_remove:, jurisdiction_to_add:, jurisdiction_to_remove:, jurisdiction_ids:) }

  let(:add_or_remove) { 'add' }
  let(:jurisdiction_to_add) { 'AL' }
  let(:jurisdiction_to_remove) { nil }
  let(:jurisdiction_ids) { ['DJ', 'ER', 'GF', 'GN', 'SX', 'FI', 'GR', 'AW', 'MS', 'KI', 'NC', 'SB', 'LC', 'AO', 'LU', 'TC', 'SH', 'MM', 'RO', 'BQ'] }

  describe '.jurisdiction_lists' do
    it 'has the right number of jursidictions for adding' do
      expect(change_jurisdictions.jurisdiction_lists['add'].length).to eq(220)
    end

    it 'has the right number of jursidictions for removing' do
      expect(change_jurisdictions.jurisdiction_lists['remove'].length).to eq(20)
    end
  end

  describe 'validations' do
    context 'when add_or_remove is nil' do
      let(:add_or_remove) { nil }

      it 'is not valid and has the correct error message' do
        expect(change_jurisdictions).not_to be_valid
        expect(change_jurisdictions.errors[:add_or_remove].first).to eq 'You must select add or remove'
      end
    end

    context 'when add_or_remove is blank' do
      let(:add_or_remove) { '' }

      it 'is not valid and has the correct error message' do
        expect(change_jurisdictions).not_to be_valid
        expect(change_jurisdictions.errors[:add_or_remove].first).to eq 'You must select add or remove'
      end
    end

    context 'when add_or_remove is not in the lis' do
      let(:add_or_remove) { 'something' }

      it 'is not valid and has the correct error message' do
        expect(change_jurisdictions).not_to be_valid
        expect(change_jurisdictions.errors[:add_or_remove].first).to eq 'You must select add or remove'
      end
    end

    context 'when add_or_remove is add' do
      context 'when jurisdiction_to_add is nil' do
        let(:jurisdiction_to_add) { nil }

        it 'is not valid and has the correct error message' do
          expect(change_jurisdictions).not_to be_valid
          expect(change_jurisdictions.errors[:jurisdiction_to_add].first).to eq 'You must select a jurisdiction to add'
        end
      end

      context 'when jurisdiction_to_add is blank' do
        let(:jurisdiction_to_add) { '' }

        it 'is not valid and has the correct error message' do
          expect(change_jurisdictions).not_to be_valid
          expect(change_jurisdictions.errors[:jurisdiction_to_add].first).to eq 'You must select a jurisdiction to add'
        end
      end

      context 'when jurisdiction_to_add is already added' do
        let(:jurisdiction_to_add) { 'GF' }

        it 'is not valid and has the correct error message' do
          expect(change_jurisdictions).not_to be_valid
          expect(change_jurisdictions.errors[:jurisdiction_to_add].first).to eq 'You must select a jurisdiction to add'
        end
      end

      it 'is valid' do
        expect(change_jurisdictions).to be_valid
      end
    end

    context 'when add_or_remove is remove' do
      let(:add_or_remove) { 'remove' }
      let(:jurisdiction_to_add) { nil }
      let(:jurisdiction_to_remove) { 'GF' }

      context 'when jurisdiction_to_remove is nil' do
        let(:jurisdiction_to_remove) { nil }

        it 'is not valid and has the correct error message' do
          expect(change_jurisdictions).not_to be_valid
          expect(change_jurisdictions.errors[:jurisdiction_to_remove].first).to eq 'You must select a jurisdiction to remove'
        end
      end

      context 'when jurisdiction_to_remove is blank' do
        let(:jurisdiction_to_remove) { '' }

        it 'is not valid and has the correct error message' do
          expect(change_jurisdictions).not_to be_valid
          expect(change_jurisdictions.errors[:jurisdiction_to_remove].first).to eq 'You must select a jurisdiction to remove'
        end
      end

      context 'when jurisdiction_to_remove is already removed' do
        let(:jurisdiction_to_remove) { 'AL' }

        it 'is not valid and has the correct error message' do
          expect(change_jurisdictions).not_to be_valid
          expect(change_jurisdictions.errors[:jurisdiction_to_remove].first).to eq 'You must select a jurisdiction to remove'
        end
      end

      it 'is valid' do
        expect(change_jurisdictions).to be_valid
      end
    end
  end
end

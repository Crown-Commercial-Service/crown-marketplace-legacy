require 'rails_helper'

RSpec.describe ChangeLog do
  describe 'associations' do
    let(:change_log) { create(:change_log) }

    it { is_expected.to belong_to(:framework) }
    it { is_expected.to belong_to(:user) }

    it 'has the framework relationship' do
      expect(change_log.framework).to be_present
    end

    it 'has the user relationship' do
      expect(change_log.user).to be_present
    end
  end

  describe 'change_types' do
    it 'matches the expected change types' do
      expect(described_class::CHANGE_TYPES.keys).to eq(%i[upload_supplier_data update_supplier_information update_supplier_contact_information update_supplier_additional_information update_supplier_framework_lot_status update_supplier_framework_lot_services update_supplier_framework_lot_rates update_supplier_framework_lot_jurisdictions update_supplier_framework_lot_branch])
      expect(described_class::CHANGE_TYPES.values).to eq(%w[upload_supplier_data update_supplier_information update_supplier_contact_information update_supplier_additional_information update_supplier_framework_lot_status update_supplier_framework_lot_services update_supplier_framework_lot_rates update_supplier_framework_lot_jurisdictions update_supplier_framework_lot_branch])
    end

    context 'when trying to save a change type that is not in the list' do
      let(:change_log) { build(:change_log, change_type: Faker::String.random(length: 3..12)) }

      it 'is not valid' do
        expect(change_log).not_to be_valid
        expect(change_log.errors[:change_type]).to be_present
      end

      it 'returns false when saving' do
        expect(change_log.save).to be(false)
        expect(change_log.errors[:change_type]).to be_present
      end
    end
  end

  describe '.short_id' do
    let(:change_log) { create(:change_log) }

    it 'returns the shortened uuid' do
      expect(change_log.short_id).to eq("##{change_log.id[..7]}")
    end
  end

  describe '.changed_by' do
    let(:user) { create(:user) }
    let(:change_log) { create(:change_log, user:) }

    it 'returns the user email' do
      expect(change_log.changed_by).to eq(user.email)
    end
  end
end

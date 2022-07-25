require 'rails_helper'

RSpec.describe SupplyTeachers::RM6238::Journey::FTAToPermHireDateNotice, type: :model do
  subject(:step) { described_class.new }

  describe 'validations' do
    it 'is valid' do
      expect(step).to be_valid
    end
  end

  describe '.next_step_class' do
    it 'returns Journey::FTAToPermFixedTermFee' do
      expect(step.next_step_class).to be SupplyTeachers::RM6238::Journey::FTAToPermFixedTermFee
    end
  end

  describe '.slug' do
    it 'returns fta-to-perm-hire-date-notice' do
      expect(step.slug).to eq 'fta-to-perm-hire-date-notice'
    end
  end

  describe '.template' do
    it 'returns journey/fta_to_perm_hire_date_notice' do
      expect(step.template).to eq 'journey/fta_to_perm_hire_date_notice'
    end
  end

  describe '.final?' do
    it 'returns false' do
      expect(step.final?).to be false
    end
  end
end

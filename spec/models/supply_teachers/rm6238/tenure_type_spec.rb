require 'rails_helper'

RSpec.describe SupplyTeachers::RM6238::TenureType, type: :model do
  subject(:tenure_types) { described_class.all }

  let(:first_tenure_type) { tenure_types.first }
  let(:all_codes) { described_class.all_codes }

  it 'loads tenure_types from CSV' do
    expect(tenure_types.count).to eq(2)
  end

  it 'populates attributes of first rate_term' do
    expect(first_tenure_type.code).to eq('daily')
    expect(first_tenure_type.description).to eq('Daily Supply')
  end

  it 'only has unique codes' do
    expect(all_codes.uniq).to contain_exactly(*all_codes)
  end

  it 'all have descriptions' do
    expect(tenure_types.select { |tenure_type| tenure_type.description.blank? }).to be_empty
  end

  describe '.[]' do
    it 'looks up rate term description by code' do
      expect(described_class['6_weeks_plus']).to eq('Long Term (6 weeks+)')
    end
  end

  describe '.all_codes' do
    it 'returns codes for all tenure_types' do
      expect(all_codes.count).to eq(tenure_types.count)
      expect(all_codes.first).to eq(first_tenure_type.code)
    end
  end
end

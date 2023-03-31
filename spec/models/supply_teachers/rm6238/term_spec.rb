require 'rails_helper'

RSpec.describe SupplyTeachers::RM6238::Term do
  subject(:terms) { described_class.all }

  let(:first_term) { terms.first }
  let(:all_codes) { described_class.all_codes }

  it 'loads terms from CSV' do
    expect(terms.count).to eq(2)
  end

  it 'populates attributes of first rate_term' do
    expect(first_term.code).to eq('daily')
    expect(first_term.description).to eq('Daily Supply')
  end

  it 'only has unique codes' do
    expect(all_codes.uniq).to match_array(all_codes)
  end

  it 'all have descriptions' do
    expect(terms.select { |term| term.description.blank? }).to be_empty
  end

  describe '.[]' do
    it 'looks up rate term description by code' do
      expect(described_class['six_weeks_plus']).to eq('Long Term (6 weeks+)')
    end
  end

  describe '.all_codes' do
    it 'returns codes for all terms' do
      expect(all_codes.count).to eq(terms.count)
      expect(all_codes.first).to eq(first_term.code)
    end
  end
end

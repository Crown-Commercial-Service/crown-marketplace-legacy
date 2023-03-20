require 'rails_helper'

RSpec.describe LegalServices::RM6240::Position do
  subject(:positions) { described_class.all }

  let(:first_position) { positions.first }
  let(:all_codes) { described_class.all_codes }

  it 'loads positions from CSV' do
    expect(positions.count).to eq(7)
  end

  it 'populates attributes of first position' do
    expect(first_position.code).to eq('1')
    expect(first_position.name).to eq('Partner')
  end

  it 'only has unique codes' do
    expect(all_codes.uniq).to match_array(all_codes)
  end

  it 'all have names' do
    expect(positions.select { |l| l.name.blank? }).to be_empty
  end

  describe '.[]' do
    it 'looks up position by code' do
      expect(described_class['1'].code).to eq('1')
    end
  end

  describe '.all_codes' do
    it 'returns codes for all positions' do
      expect(all_codes.count).to eq(positions.count)
      expect(all_codes.first).to eq(first_position.code)
    end
  end
end

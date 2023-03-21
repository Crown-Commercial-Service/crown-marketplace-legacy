require 'rails_helper'

RSpec.describe LegalServices::RM6240::Jurisdiction do
  subject(:jurisdictions) { described_class.all }

  let(:first_jurisdiction) { jurisdictions.first }
  let(:all_codes) { described_class.all_codes }

  it 'loads jurisdictions from CSV' do
    expect(jurisdictions.count).to eq(3)
  end

  it 'populates attributes of first jurisdiction' do
    expect(first_jurisdiction.code).to eq('a')
    expect(first_jurisdiction.name).to eq('England & Wales')
  end

  it 'only has unique codes' do
    expect(all_codes.uniq).to contain_exactly(*all_codes)
  end

  it 'all have names' do
    expect(jurisdictions.select { |l| l.name.blank? }).to be_empty
  end

  describe '.[]' do
    it 'looks up jurisdiction by code' do
      expect(described_class['a'].code).to eq('a')
    end
  end

  describe '.all_codes' do
    it 'returns codes for all jurisdictions' do
      expect(all_codes.count).to eq(jurisdictions.count)
      expect(all_codes.first).to eq(first_jurisdiction.code)
    end
  end
end

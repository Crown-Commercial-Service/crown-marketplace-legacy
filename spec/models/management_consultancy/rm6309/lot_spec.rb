require 'rails_helper'

RSpec.describe ManagementConsultancy::RM6309::Lot do
  subject(:lots) { described_class.all }

  let(:first_lot) { lots.first }
  let(:all_numbers) { described_class.all_numbers }

  it 'loads lots from CSV' do
    expect(lots.count).to eq(10)
  end

  it 'populates attributes of first lot' do
    expect(first_lot.number).to eq('MCF4.1')
    expect(first_lot.description).to eq('Business')
  end

  it 'only has unique numbers' do
    expect(all_numbers.uniq).to match_array(all_numbers)
  end

  it 'all have descriptions' do
    expect(lots.select { |l| l.description.blank? }).to be_empty
  end

  describe '.[]' do
    it 'looks up lot by number' do
      expect(described_class['MCF4.2'].number).to eq('MCF4.2')
    end
  end

  describe '.all_numbers' do
    it 'returns numbers for all lots' do
      expect(all_numbers.count).to eq(lots.count)
      expect(all_numbers.first).to eq(first_lot.number)
    end
  end
end

require 'rails_helper'

RSpec.describe SupplyTeachers::RM6238::Lot do
  subject(:lots) { described_class.all }

  let(:first_lot) { lots.first }
  let(:all_numbers) { described_class.all_numbers }

  it 'loads lots from CSV' do
    expect(lots.count).to eq(4)
  end

  it 'only has unique numbers' do
    expect(all_numbers.uniq).to match_array(all_numbers)
  end

  it 'all have descriptions' do
    expect(lots.select { |l| l.description.blank? }).to be_empty
  end

  it 'populates attributes of first lot' do
    expect(first_lot.number).to eq('1')
    expect(first_lot.description).to eq('Direct provision')
  end

  describe '.all_numbers' do
    it 'returns numbers for all lots' do
      expect(all_numbers.count).to eq(lots.count)
      expect(all_numbers.first).to eq(first_lot.number)
    end
  end
end

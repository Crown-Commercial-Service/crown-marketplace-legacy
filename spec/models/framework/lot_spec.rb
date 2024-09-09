require 'rails_helper'

RSpec.describe Framework::Lot do
  it { is_expected.to belong_to(:framework) }
  it { is_expected.to have_many(:services) }

  describe 'when considering the framework' do
    let(:result) { Framework.find(framework).lots.count }

    context 'and the framework is RM6187' do
      let(:framework) { 'RM6187' }

      it 'has the correct number of lots' do
        expect(result).to eq(9)
      end
    end

    context 'and the framework is RM6240' do
      let(:framework) { 'RM6240' }

      it 'has the correct number of lots' do
        expect(result).to eq(3)
      end
    end

    context 'and the framework is RM6238' do
      let(:framework) { 'RM6238' }

      it 'has the correct number of lots' do
        expect(result).to eq(4)
      end
    end
  end
end

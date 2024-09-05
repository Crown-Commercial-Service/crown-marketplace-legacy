require 'rails_helper'

RSpec.describe Framework::Lot::Service do
  it { is_expected.to belong_to(:lot) }

  describe 'when considering the framework' do
    let(:result) { Framework::Lot.find("#{framework}_#{number}").services.count }

    context 'and the framework is RM6187' do
      let(:framework) { 'RM6187' }

      [
        ['1', 14],
        ['2', 9],
        ['3', 13],
        ['4', 24],
        ['5', 10],
        ['6', 13],
        ['7', 21],
        ['8', 8],
        ['9', 19],
      ].each do |lot_number, expected_result|
        context "and the lot is #{lot_number}" do
          let(:number) { lot_number }

          it 'has the correct number of services' do
            expect(result).to eq(expected_result)
          end
        end
      end
    end

    context 'and the framework is RM6240' do
      let(:framework) { 'RM6240' }

      [
        ['1', 40],
        ['2', 15],
        ['3', 1],
      ].each do |lot_number, expected_result|
        context "and the lot is #{lot_number}" do
          let(:number) { lot_number }

          it 'has the correct number of services' do
            expect(result).to eq(expected_result)
          end
        end
      end
    end

    context 'and the framework is RM6238' do
      let(:framework) { 'RM6238' }

      [
        ['1', 0],
        ['2.1', 0],
        ['2.2', 0],
        ['4', 0],
      ].each do |lot_number, expected_result|
        context "and the lot is #{lot_number}" do
          let(:number) { lot_number }

          it 'has the correct number of services' do
            expect(result).to eq(expected_result)
          end
        end
      end
    end
  end
end

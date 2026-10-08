require 'rails_helper'

module SupplyTeachers::RM6376::Admin
  RSpec.describe SupplyTeachers::RM6376::Admin::FilesProcessor do
    subject(:processor) { described_class.new(double('upload')) } # rubocop:disable RSpec/VerifiedDoubles

    describe '#convert_rate' do
      context 'when converting currency to pence (:pence)' do
        it 'converts a float string correctly without floating-point precision loss' do
          expect(processor.send(:convert_rate, '36.55', :pence)).to eq(3655)
        end

        it 'converts a float string correctly without floating-point precision loss 36.49' do
          expect(processor.send(:convert_rate, '36.49', :pence)).to eq(3649)
        end

        it 'converts a float number correctly' do
          expect(processor.send(:convert_rate, 12.50, :pence)).to eq(1250)
        end

        it 'converts an integer correctly' do
          expect(processor.send(:convert_rate, 40, :pence)).to eq(4000)
        end
      end

      context 'when converting percentages (:percentage)' do
        it 'converts a decimal string to basis points' do
          expect(processor.send(:convert_rate, '0.05', :percentage)).to eq(500)
        end

        it 'converts a float decimal to basis points' do
          expect(processor.send(:convert_rate, 0.1234, :percentage)).to eq(1234)
        end
      end

      context 'when handling edge cases' do
        it 'returns nil when rate is nil' do
          expect(processor.send(:convert_rate, nil, :pence)).to be_nil
        end

        it 'returns 0 for zero inputs' do
          expect(processor.send(:convert_rate, '0', :pence)).to eq(0)
        end
      end
    end

    describe '#convert_rate_to_percentage' do
      it 'converts a decimal string to basis points' do
        expect(processor.send(:convert_rate_to_percentage, '0.05')).to eq(500)
      end

      it 'converts a float decimal without floating-point precision loss' do
        expect(processor.send(:convert_rate_to_percentage, 0.003655)).to eq(37)
      end

      it 'converts a standard float to basis points' do
        expect(processor.send(:convert_rate_to_percentage, 0.1234)).to eq(1234)
      end

      it 'converts an integer rate correctly' do
        expect(processor.send(:convert_rate_to_percentage, 1)).to eq(10_000)
      end

      it 'returns nil when rate is nil' do
        expect(processor.send(:convert_rate_to_percentage, nil)).to be_nil
      end

      it 'returns 0 for zero inputs' do
        expect(processor.send(:convert_rate_to_percentage, '0')).to eq(0)
      end
    end
  end
end

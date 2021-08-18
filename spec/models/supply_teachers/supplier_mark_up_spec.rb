require 'rails_helper'

RSpec.describe SupplyTeachers::SupplierMarkUp, type: :model do
  let(:supplier_mark_up) { described_class.new(daily_rate: daily_rate, markup_rate: markup_rate) }
  let(:daily_rate) { '220' }
  let(:markup_rate) { 0.44 }

  describe '#worker_cost' do
    it 'calculates the worker cost out of the daily rate' do
      expect(supplier_mark_up.worker_cost).to be_within(0.1).of(152.78)
    end
  end

  describe '#agency_fee' do
    it 'calculates the agency’s fee out of the daily rate' do
      expect(supplier_mark_up.agency_fee).to be_within(0.1).of(67.22)
    end
  end

  describe 'valid?' do
    context 'when the salary does not resolve to an integer' do
      let(:daily_rate) { '3478j' }

      it 'is not valid' do
        expect(supplier_mark_up.valid?).to be false
      end
    end

    context 'when the salary is 0' do
      let(:daily_rate) { '0' }

      it 'is not valid' do
        expect(supplier_mark_up.valid?).to be false
      end
    end

    context 'when the salary is negative' do
      let(:daily_rate) { '-31' }

      it 'is not valid' do
        expect(supplier_mark_up.valid?).to be false
      end
    end

    context 'when the salary is greater than 0' do
      let(:daily_rate) { '45' }

      it 'is valid' do
        expect(supplier_mark_up.valid?).to be true
      end
    end

    context 'when the salary is a float' do
      let(:daily_rate) { '8.67' }

      it 'is valid' do
        expect(supplier_mark_up.valid?).to be true
      end
    end
  end
end

require 'rails_helper'

RSpec.describe LegalServices::RM6374::Journey::ChooseCallOffMechanism, type: :model do
  subject(:step) { described_class.new }

  describe 'attributes' do
    it { is_expected.to respond_to(:lot_number) }
    it { is_expected.to respond_to(:call_off_mechanism) }
  end

  describe 'validations' do
    context 'when call_off_mechanism is nil' do
      before { step.call_off_mechanism = nil }

      it 'is not valid' do
        expect(step).not_to be_valid
        expect(step.errors[:call_off_mechanism]).to be_present
      end
    end

    context 'when call_off_mechanism is not in the allowed list' do
      before { step.call_off_mechanism = 'invalid_mechanism' }

      it 'is not valid' do
        expect(step).not_to be_valid
        expect(step.errors[:call_off_mechanism]).to be_present
      end
    end

    context 'when call_off_mechanism is a valid option' do
      described_class::CALL_OFF_MECHANISM_OPTIONS.each do |valid_option|
        it "is valid with '#{valid_option}'" do
          step.call_off_mechanism = valid_option
          expect(step).to be_valid
        end
      end
    end
  end

  describe '#lot' do
    let(:lot_number) { '2a' }
    let(:expected_lot_id) { "RM6374.#{lot_number}" }
    let(:lot_mock) { instance_double(Lot) }

    before do
      step.lot_number = lot_number
      allow(Lot).to receive(:find).with(expected_lot_id).and_return(lot_mock)
    end

    it 'finds the lot using the combined framework and lot number' do
      expect(step.lot).to eq(lot_mock)
    end
  end

  describe '#next_step_class' do
    context "when call_off_mechanism is 'award_with_competition'" do
      before { step.call_off_mechanism = 'award_with_competition' }

      it 'returns Journey::SuppliersComparison' do
        expect(step.next_step_class).to eq(LegalServices::RM6374::Journey::SuppliersComparison)
      end
    end

    context "when call_off_mechanism is 'rapid_award'" do
      before { step.call_off_mechanism = 'rapid_award' }

      it 'returns Journey::ReviewProspectus' do
        expect(step.next_step_class).to eq(LegalServices::RM6374::Journey::ReviewProspectus)
      end
    end

    context "when call_off_mechanism is 'quotation_process'" do
      before { step.call_off_mechanism = 'quotation_process' }

      it 'returns Journey::CompareSelectSuppliers' do
        expect(step.next_step_class).to eq(LegalServices::RM6374::Journey::CompareSelectSuppliers)
      end
    end
  end
end
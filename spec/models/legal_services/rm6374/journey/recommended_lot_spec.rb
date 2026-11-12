require 'rails_helper'

RSpec.describe LegalServices::RM6374::Journey::RecommendedLot do
  subject(:step) do
    described_class.new(
      specialism:,
      recommended_or_alternatives:,
      lot_number:,
      sector:,
      service_numbers:
    )
  end

  let(:specialism) { 'general' }
  let(:recommended_or_alternatives) { 'recommended' }
  let(:lot_number) { '1' }
  let(:sector) { 'central_government' }
  let(:service_numbers) { ['1'] }

  describe 'validations' do
    context 'when no recommended_or_alternatives option is provided' do
      let(:recommended_or_alternatives) { '' }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:recommended_or_alternatives].first).to eq 'Select an option'
      end
    end

    context 'when an invalid recommended_or_alternatives option is provided' do
      let(:recommended_or_alternatives) { 'invalid-option' }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:recommended_or_alternatives].first).to eq 'Select an option'
      end
    end

    context 'when recommended_or_alternatives is recommended' do
      it 'is valid without a lot_number' do
        let(:lot_number) { nil } if defined?(let)

        expect(step).to be_valid
      end
    end

    context 'when recommended_or_alternatives is alternatives' do
      let(:recommended_or_alternatives) { 'alternatives' }

      before do
        allow(LegalServices::RM6374::Journey::CrossLotCheck).to receive(:evaluate)
          .and_return({ alternatives: [1, 2] })
      end

      context 'when lot_number is not provided' do
        let(:lot_number) { nil }

        it 'is not valid and has the correct error message' do
          expect(step).not_to be_valid
          expect(step.errors[:lot_number].first).to eq 'Select an option'
        end
      end

      context 'when an invalid lot_number is provided' do
        let(:lot_number) { '3' }

        it 'is not valid and has the correct error message' do
          expect(step).not_to be_valid
          expect(step.errors[:lot_number].first).to eq 'Select an option'
        end
      end

      context 'when a valid lot_number is provided' do
        let(:lot_number) { '2' }

        it 'is valid' do
          expect(step).to be_valid
        end
      end
    end
  end

  describe '#result' do
    let(:evaluation) { { recommended: '1a', alternatives: [2] } }

    context 'when specialism is specific' do
      let(:specialism) { 'specific' }

      it 'evaluates CrossLotCheck with a nil selected_sector' do
        allow(LegalServices::RM6374::Journey::CrossLotCheck).to receive(:evaluate)
          .with(selected_sector: nil, selected_specialisms: service_numbers)
          .and_return(evaluation)

        expect(step.result).to eq evaluation
      end
    end

    context 'when specialism is not specific' do
      let(:specialism) { 'general' }

      it 'evaluates CrossLotCheck with the given sector' do
        allow(LegalServices::RM6374::Journey::CrossLotCheck).to receive(:evaluate)
          .with(selected_sector: sector, selected_specialisms: service_numbers)
          .and_return(evaluation)

        expect(step.result).to eq evaluation
      end
    end

    it 'memoizes the result' do
      expect(LegalServices::RM6374::Journey::CrossLotCheck).to receive(:evaluate) # rubocop:disable RSpec/MessageSpies
        .once
        .and_return(evaluation)

      2.times { step.result }
    end
  end

  describe '#next_step_class' do
    it 'returns Journey::ChooseJurisdiction' do
      expect(step.next_step_class).to be LegalServices::RM6374::Journey::ChooseJurisdiction
    end
  end
end

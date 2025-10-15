require 'rails_helper'

RSpec.describe LegalPanelForGovernment::RM6360::Journey::HaveYouReviewed do
  subject(:step) { described_class.new(lot_id:, have_you_reviewed:) }

  let(:have_you_reviewed) { 'yes' }
  let(:lot_id) { 'RM6360.1' }

  describe 'validations' do
    context 'when no have_you_reviewed is provided' do
      let(:have_you_reviewed) { '' }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:have_you_reviewed].first).to eq 'Select yes if you have shortlisted suppliers'
      end
    end

    context 'when have_you_reviewed is not in the list' do
      let(:have_you_reviewed) { 'non-valid-option' }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:have_you_reviewed].first).to eq 'Select yes if you have shortlisted suppliers'
      end
    end

    context 'when an option that is in the list provided' do
      it 'is valid' do
        expect(step).to be_valid
      end
    end
  end

  describe '.next_step_class' do
    context 'and the central government is yes' do
      let(:have_you_reviewed) { 'yes' }

      it 'returns Journey::InformationAboutYourRequirement' do
        expect(step.next_step_class).to be LegalPanelForGovernment::RM6360::Journey::SelectSuppliersForComparison
      end
    end

    context 'and the central government is no' do
      let(:have_you_reviewed) { 'no' }

      it 'returns Journey::Suppliers' do
        expect(step.next_step_class).to be LegalPanelForGovernment::RM6360::Journey::Suppliers
      end
    end
  end

  describe '.permit_list' do
    it 'returns a list of the permitted attributes' do
      expect(described_class.permit_list).to eq [:lot_id, :have_you_reviewed, {}]
    end
  end

  describe '.permitted_keys' do
    it 'returns a list of the permitted keys' do
      expect(described_class.permitted_keys).to eq %i[lot_id have_you_reviewed]
    end
  end

  describe '.slug' do
    it 'returns have-you-reviewed' do
      expect(step.slug).to eq 'have-you-reviewed'
    end
  end

  describe '.template' do
    it 'returns journey/have_you_reviewed' do
      expect(step.template).to eq 'journey/have_you_reviewed'
    end
  end

  describe '.final?' do
    it 'returns false' do
      expect(step.final?).to be false
    end
  end

  describe '.lot' do
    let(:result) { step.lot }

    context 'when the lot exists' do
      it 'returns the lot' do
        expect(result.id).to eq 'RM6360.1'
        expect(result.name).to eq 'Core Legal Services'
      end
    end

    context 'when the lot does not exist' do
      let(:lot_id) { 'RM6360.6' }

      it 'returns nil' do
        expect { result }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end

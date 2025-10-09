require 'rails_helper'

RSpec.describe LegalPanelForGovernment::RM6360::Journey::InformationAboutYourRequirement do
  subject(:step) { described_class.new(requirement_start_date_month:, requirement_start_date_year:, requirement_end_date_month:, requirement_end_date_year:, requirement_estimated_total_value:, ccs_can_contact_you:) }

  let(:requirement_start_date_month) { '10' }
  let(:requirement_start_date_year) { '2025' }
  let(:requirement_end_date_month) { '10' }
  let(:requirement_end_date_year) { '2026' }
  let(:requirement_estimated_total_value) { 123_456 }
  let(:ccs_can_contact_you) { 'yes' }

  describe 'validations' do
    context 'when no requirement_start_date_month is provided' do
      let(:requirement_start_date_month) { '' }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:requirement_start_date].first).to eq 'Enter the intended start date, including the month and year'
      end
    end

    context 'when no requirement_start_date_year is provided' do
      let(:requirement_start_date_year) { '' }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:requirement_start_date].first).to eq 'Enter the intended start date, including the month and year'
      end
    end

    context 'when the start date is not real' do
      let(:requirement_start_date_month) { '13' }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:requirement_start_date].first).to eq 'Enter the intended start date, including the month and year'
      end
    end

    context 'when no requirement_end_date_month is provided' do
      let(:requirement_end_date_month) { '' }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:requirement_end_date].first).to eq 'Enter the intended end date, including the month and year'
      end
    end

    context 'when no requirement_end_date_year is provided' do
      let(:requirement_end_date_year) { '' }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:requirement_end_date].first).to eq 'Enter the intended end date, including the month and year'
      end
    end

    context 'when the end date is not real' do
      let(:requirement_end_date_month) { '13' }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:requirement_end_date].first).to eq 'Enter the intended end date, including the month and year'
      end
    end

    context 'when the end date is before the start date' do
      let(:requirement_end_date_year) { '1997' }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:requirement_end_date].first).to eq 'The intended end date must be after the intended start date'
      end
    end

    context 'when no requirement estimated total value is present' do
      let(:requirement_estimated_total_value) { nil }

      it 'is not valid and has the correct error message' do
        expect(step.valid?).to be false
        expect(step.errors[:requirement_estimated_total_value].first).to eq 'The estimated total value must be a whole number greater than 0'
      end
    end

    context 'when the requirement estimated total value is not a number' do
      let(:requirement_estimated_total_value) { 'Morag' }

      it 'is not valid and has the correct error message' do
        expect(step.valid?).to be false
        expect(step.errors[:requirement_estimated_total_value].first).to eq 'The estimated total value must be a whole number greater than 0'
      end
    end

    context 'when the requirement estimated total value is not an integer' do
      let(:requirement_estimated_total_value) { 1_000_000.67 }

      it 'is not valid and has the correct error message' do
        expect(step.valid?).to be false
        expect(step.errors[:requirement_estimated_total_value].first).to eq 'The estimated total value must be a whole number greater than 0'
      end
    end

    context 'when the requirement estimated total value is less than 1' do
      let(:requirement_estimated_total_value) { 0 }

      it 'is not valid and has the correct error message' do
        expect(step.valid?).to be false
        expect(step.errors[:requirement_estimated_total_value].first).to eq 'The estimated total value must be a whole number greater than 0'
      end
    end

    context 'when the requirement estimated total value is more than 999,999,999,999' do
      let(:requirement_estimated_total_value) { 1_000_000_000_000 }

      it 'is not valid and has the correct error message' do
        expect(step.valid?).to be false
        expect(step.errors[:requirement_estimated_total_value].first).to eq 'The estimated total value must be less than 1,000,000,000,000 (1 trillion)'
      end
    end

    context 'when no ccs_can_contact_you is provided' do
      let(:ccs_can_contact_you) { '' }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:ccs_can_contact_you].first).to eq 'You must select an option'
      end
    end

    context 'when ccs_can_contact_you is not in the list' do
      let(:ccs_can_contact_you) { 'non-valid-option' }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:ccs_can_contact_you].first).to eq 'You must select an option'
      end
    end

    context 'when all attributes are valid' do
      it 'is valid' do
        expect(step).to be_valid
      end
    end
  end

  describe '.next_step_class' do
    it 'returns Journey::SelectLot' do
      expect(step.next_step_class).to be LegalPanelForGovernment::RM6360::Journey::SelectLot
    end
  end

  describe '.permit_list' do
    it 'returns a list of the permitted attributes' do
      expect(described_class.permit_list).to eq [:requirement_start_date_day, :requirement_start_date_month, :requirement_start_date_year, :requirement_end_date_day, :requirement_end_date_month, :requirement_end_date_year, :requirement_estimated_total_value, :ccs_can_contact_you, {}]
    end
  end

  describe '.permitted_keys' do
    it 'returns a list of the permitted keys' do
      expect(described_class.permitted_keys).to eq %i[requirement_start_date_day requirement_start_date_month requirement_start_date_year requirement_end_date_day requirement_end_date_month requirement_end_date_year requirement_estimated_total_value ccs_can_contact_you]
    end
  end

  describe '.slug' do
    it 'returns information-about-your-requirement' do
      expect(step.slug).to eq 'information-about-your-requirement'
    end
  end

  describe '.template' do
    it 'returns journey/information_about_your_requirement' do
      expect(step.template).to eq 'journey/information_about_your_requirement'
    end
  end

  describe '.final?' do
    it 'returns false' do
      expect(step.final?).to be false
    end
  end
end

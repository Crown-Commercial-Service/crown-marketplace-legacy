require 'rails_helper'

RSpec.describe SupplyTeachers::RM6238::Journey::WorkerType do
  subject(:step) { described_class.new(worker_type: worker_type) }

  let(:worker_type) { 'agency_supplied' }

  describe 'validations' do
    context 'when no worker_type is provided' do
      let(:worker_type) { '' }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:worker_type].first).to eq 'Select yes if you want an agency to supply the worker'
      end
    end

    context 'when worker_type is not in the list' do
      let(:worker_type) { 'non-valid-option' }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:worker_type].first).to eq 'Select yes if you want an agency to supply the worker'
      end
    end

    context 'when an option that is in the list provided' do
      it 'is valid' do
        expect(step).to be_valid
      end
    end
  end

  describe '.next_step_class' do
    context 'and the worker type is agency_supplied' do
      let(:worker_type) { 'agency_supplied' }

      it 'returns Journey::SchoolPostcodeNominatedWorker' do
        expect(step.next_step_class).to be SupplyTeachers::RM6238::Journey::PayrollProvider
      end
    end

    context 'and the worker type is nominated' do
      let(:worker_type) { 'nominated' }

      it 'returns Journey::PayrollProvider' do
        expect(step.next_step_class).to be SupplyTeachers::RM6238::Journey::SchoolPostcodeNominatedWorker
      end
    end
  end

  describe '.permit_list' do
    it 'returns a list of the permitted attributes' do
      expect(described_class.permit_list).to eq [:worker_type, {}]
    end
  end

  describe '.permitted_keys' do
    it 'returns a list of the permitted keys' do
      expect(described_class.permitted_keys).to eq %i[worker_type]
    end
  end

  describe '.slug' do
    it 'returns worker-type' do
      expect(step.slug).to eq 'worker-type'
    end
  end

  describe '.template' do
    it 'returns journey/worker_type' do
      expect(step.template).to eq 'journey/worker_type'
    end
  end

  describe '.final?' do
    it 'returns false' do
      expect(step.final?).to be false
    end
  end
end

require 'rails_helper'

RSpec.describe SupplyTeachers::RM6238::Journey::NominatedWorkerResults do
  subject(:step) { described_class.new(postcode: 'SW1A 1AA', radius: '5') }

  describe '.determine_position_id' do
    it 'returns 39' do
      expect(step.determine_position_id).to eq(39)
    end
  end

  describe '.lot_id' do
    it 'returns RM6238.1' do
      expect(step.send(:lot_id)).to eq('RM6238.1')
    end
  end

  describe '.inputs' do
    it 'returns the inputs' do
      expect(step.inputs).to eq(
        looking_for: 'Individual worker',
        worker_type: 'Nominated',
        postcode: 'SW1A 1AA',
        radius: '5 miles'
      )
    end
  end

  describe '.slug' do
    it 'returns nominated-worker-results' do
      expect(step.slug).to eq 'nominated-worker-results'
    end
  end

  describe '.final?' do
    it 'returns true' do
      expect(step.final?).to be true
    end
  end
end

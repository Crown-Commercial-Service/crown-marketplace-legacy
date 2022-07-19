require 'rails_helper'

RSpec.describe SupplyTeachers::RM6238::Journey::NominatedWorkerResults, type: :model do
  subject(:step) { described_class.new(postcode: 'SW1A 1AA', radius: '5') }

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

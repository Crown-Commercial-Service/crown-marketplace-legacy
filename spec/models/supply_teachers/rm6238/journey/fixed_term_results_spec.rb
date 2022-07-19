require 'rails_helper'

RSpec.describe SupplyTeachers::RM6238::Journey::FixedTermResults, type: :model do
  subject(:step) { described_class.new(postcode: 'SW1A 1AA', radius: '5') }

  describe '.inputs' do
    it 'returns the inputs' do
      expect(step.inputs).to eq(
        looking_for: 'Individual worker',
        worker_type: 'Supplied by agency',
        payroll_provider: 'School',
        postcode: 'SW1A 1AA',
        radius: '5 miles'
      )
    end
  end

  describe '.slug' do
    it 'returns fixed-term-results' do
      expect(step.slug).to eq 'fixed-term-results'
    end
  end

  describe '.final?' do
    it 'returns true' do
      expect(step.final?).to be true
    end
  end
end

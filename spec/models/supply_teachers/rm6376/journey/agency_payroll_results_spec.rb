require 'rails_helper'

RSpec.describe SupplyTeachers::RM6376::Journey::AgencyPayrollResults do
  subject(:step) { described_class.new(postcode: 'SW1A 1AA', position_number: position_number, radius: '5', framework: 'RM6376') }

  let(:position_number) { '1' }

  describe '.determine_position_id' do
    it 'adds the postion_idt' do
      expect(step.determine_position_id).to eq('RM6376.1.1')
    end
  end

  describe '.position' do
    it 'adds the postion_id' do
      expect(step.position).to eq(Position.find('RM6376.1.1'))
    end
  end

  describe '.lot_id' do
    it 'returns RM6376.1' do
      expect(step.send(:lot_id)).to eq('RM6376.1')
    end
  end

  describe '.inputs' do
    it 'returns the inputs' do
      expect(step.inputs).to eq(
        looking_for: 'Individual worker',
        worker_type: 'Supplied by agency',
        payroll_provider: 'Agency',
        postcode: 'SW1A 1AA',
        job_type: 'STEM Teacher (Inc. Qualified Teachers, Tutors)',
        radius: '5 miles'
      )
    end
  end

  describe '.slug' do
    it 'returns agency-payroll-results' do
      expect(step.slug).to eq 'agency-payroll-results'
    end
  end

  describe '.final?' do
    it 'returns true' do
      expect(step.final?).to be true
    end
  end
end

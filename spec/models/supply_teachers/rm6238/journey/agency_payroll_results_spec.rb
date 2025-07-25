require 'rails_helper'

RSpec.describe SupplyTeachers::RM6238::Journey::AgencyPayrollResults do
  subject(:step) { described_class.new(postcode: 'SW1A 1AA', position_id: position_id, offset: offset, radius: '5') }

  let(:position_id) { '41' }
  let(:offset) { '0' }

  describe '.determine_position_id' do
    it 'adds the postion_id to the offset' do
      expect(step.determine_position_id).to eq(41)
    end

    context 'when the offset is 5' do
      let(:offset) { '5' }

      it 'adds the postion_id to the offset' do
        expect(step.determine_position_id).to eq(46)
      end
    end
  end

  describe '.position' do
    it 'adds the postion_id to the offset' do
      expect(step.position).to eq(Position.find(41))
    end

    context 'when the offset is 5' do
      let(:offset) { '5' }

      it 'adds the postion_id to the offset' do
        expect(step.position).to eq(Position.find(46))
      end
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
        worker_type: 'Supplied by agency',
        payroll_provider: 'Agency',
        job_type: 'Teacher: (Incl. Qualified and Unqualified Teachers, Tutors)',
        term: 'Daily Supply',
        postcode: 'SW1A 1AA',
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

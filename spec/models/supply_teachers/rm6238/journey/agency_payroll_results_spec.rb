require 'rails_helper'

RSpec.describe SupplyTeachers::RM6238::Journey::AgencyPayrollResults, type: :model do
  subject(:step) { described_class.new(postcode: 'SW1A 1AA', job_type: 'teacher', term: 'daily', radius: '5') }

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

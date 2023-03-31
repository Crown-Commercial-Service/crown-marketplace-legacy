require 'rails_helper'

RSpec.describe SupplyTeachers::RM6238::JobType do
  subject(:job_types) { described_class.all }

  let(:first_job_type) { job_types.first }
  let(:non_role_job_type) { described_class.find_by(code: 'fixed_term') }
  let(:all_codes) { described_class.all_codes }

  it 'loads job_types from CSV' do
    expect(job_types.count).to eq(8)
  end

  it 'populates attributes of first job_type' do
    expect(first_job_type.code).to eq('teacher')
    expect(first_job_type.description).to eq('Teacher: (Incl. Qualified and Unqualified Teachers, Tutors)')
  end

  it 'only has unique codes' do
    expect(all_codes.uniq).to match_array(all_codes)
  end

  it 'all have description' do
    expect(job_types.select { |jt| jt.description.blank? }).to be_empty
  end

  it 'all have boolean role attribute' do
    expect(job_types.reject { |jt| [TrueClass, FalseClass].include?(jt.role.class) }).to be_empty
  end

  describe '.[]' do
    it 'looks up job type description by code' do
      expect(described_class[first_job_type.code]).to eq(first_job_type.description)
    end
  end

  describe '.find_role_by' do
    it 'looks up role job type by code' do
      expect(described_class.find_role_by(code: first_job_type.code)).to eq(first_job_type)
    end

    it 'does not find non-role job type' do
      expect(described_class.find_role_by(code: non_role_job_type.code)).to be_nil
    end
  end

  describe '.find_term_allowed_by' do
    it 'looks up term_allowed job type by code' do
      expect(described_class.find_term_allowed_by(code: first_job_type.code)).to eq(first_job_type)
    end

    it 'does not find non term_allowed job type' do
      expect(described_class.find_term_allowed_by(code: non_role_job_type.code)).to be_nil
    end
  end

  describe '.roles' do
    it 'returns all role job types' do
      expect(described_class.roles.count).to eq(4)
      expect(described_class.roles).to include(first_job_type)
    end

    it 'does not include non-role job type' do
      expect(described_class.roles).not_to include(non_role_job_type)
    end
  end

  describe '.all_codes' do
    it 'returns codes for all services' do
      expect(all_codes.count).to eq(job_types.count)
      expect(all_codes.first).to eq(first_job_type.code)
    end
  end
end

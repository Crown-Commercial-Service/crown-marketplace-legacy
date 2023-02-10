require 'rails_helper'

RSpec.describe SupplyTeachers::RM6238::Journey::SchoolPostcodeAgencySuppliedWorker do
  subject(:step) { described_class.new(postcode: postcode) }

  let(:postcode) { 'SW1A 1AA' }

  describe 'validations' do
    before do
      Geocoder::Lookup::Test.add_stub(
        postcode, [{ 'coordinates' => [51.5149666, -0.119098] }]
      )
    end

    after do
      Geocoder::Lookup::Test.reset
    end

    let(:postcode) { valid_fake_postcode }

    context 'when no postcode is provided' do
      let(:postcode) { '' }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:location].first).to eq 'Enter a valid postcode'
      end
    end

    context 'when the postcode is not valid' do
      let(:postcode) { '123456' }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:location].first).to eq 'Enter a valid postcode'
      end
    end

    context 'when an option that is in the list provided' do
      it 'is valid' do
        expect(step).to be_valid
      end
    end
  end

  describe '.next_step_class' do
    it 'returns Journey::FixedTermResults' do
      expect(step.next_step_class).to be SupplyTeachers::RM6238::Journey::FixedTermResults
    end
  end

  describe '.permit_list' do
    it 'returns a list of the permitted attributes' do
      expect(described_class.permit_list).to eq [:postcode, :radius, {}]
    end
  end

  describe '.permitted_keys' do
    it 'returns a list of the permitted keys' do
      expect(described_class.permitted_keys).to eq %i[postcode radius]
    end
  end

  describe '.slug' do
    it 'returns school-postcode-agency-supplied-worker' do
      expect(step.slug).to eq 'school-postcode-agency-supplied-worker'
    end
  end

  describe '.template' do
    it 'returns journey/school_postcode_agency_supplied_worker' do
      expect(step.template).to eq 'journey/school_postcode_agency_supplied_worker'
    end
  end

  describe '.final?' do
    it 'returns false' do
      expect(step.final?).to be false
    end
  end
end

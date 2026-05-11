require 'rails_helper'

RSpec.describe Supplier::Framework::Lot::Branch do
  let(:supplier_framework_lot_branch) { create(:supplier_framework_lot_branch) }

  describe 'associations' do
    it { expect(supplier_framework_lot_branch).to belong_to(:supplier_framework_lot) }

    it 'has the supplier_framework_lot relationship' do
      expect(supplier_framework_lot_branch.supplier_framework_lot).to be_present
    end
  end

  describe 'validation' do
    it { expect(supplier_framework_lot_branch).to be_valid }

    it 'is not valid if postcode is nil' do
      supplier_framework_lot_branch.postcode = nil
      expect(supplier_framework_lot_branch).not_to be_valid
    end

    it 'is not valid if postcode is blank' do
      supplier_framework_lot_branch.postcode = ''
      expect(supplier_framework_lot_branch).not_to be_valid
    end

    it 'is not valid if postcode is nonsense' do
      supplier_framework_lot_branch.postcode = 'nonsense'
      expect(supplier_framework_lot_branch).not_to be_valid
      expect(supplier_framework_lot_branch.errors[:postcode].first).to eq('Enter a valid postcode')
    end

    it 'is not valid if location is blank' do
      supplier_framework_lot_branch.location = nil
      expect(supplier_framework_lot_branch).not_to be_valid
    end

    it 'is not valid if telephone_number is blank' do
      supplier_framework_lot_branch.telephone_number = ''
      expect(supplier_framework_lot_branch).not_to be_valid
    end

    it 'is not valid if contact_name is blank' do
      supplier_framework_lot_branch.contact_name = ''
      expect(supplier_framework_lot_branch).not_to be_valid
    end

    it 'is not valid if contact_email is blank' do
      supplier_framework_lot_branch.contact_email = ''
      expect(supplier_framework_lot_branch).not_to be_valid
    end
  end

  describe '.search' do
    let(:search_result) { described_class.search(point, lot_id:, position_id:, radius:) }
    let(:framework_id) { 'RM6238' }
    let(:lot_id) { 'RM6238.1' }
    let(:position_id) { "#{lot_id}.1" }
    let(:radius) { 25 }
    let(:supplier_framework) { create(:supplier_framework, framework_id:) }
    let(:supplier_framework_lot) { create(:supplier_framework_lot, supplier_framework:, lot_id:) }

    context 'when three branches exist in different locations' do
      let!(:london_1) do
        create(
          :supplier_framework_lot_branch,
          supplier_framework_lot: supplier_framework_lot,
          location: Geocoding.point(latitude: 51.5201, longitude: -0.0759)
        )
      end

      let!(:london_2) do
        create(
          :supplier_framework_lot_branch,
          supplier_framework_lot: supplier_framework_lot,
          location: Geocoding.point(latitude: 51.5263, longitude: -0.0858)
        )
      end

      let!(:edinburgh) do
        create(
          :supplier_framework_lot_branch,
          supplier_framework_lot: supplier_framework_lot,
          location: Geocoding.point(latitude: 55.9619, longitude: -3.1953)
        )
      end

      let(:point) { Geocoding.point(latitude: 51.5255, longitude: -0.0587) }

      before { create(:supplier_framework_lot_rate, supplier_framework_lot:, position_id:) }

      it 'includes nearby branches' do
        expect(search_result).to include(london_1, london_2)
      end

      it 'excludes far away branches' do
        expect(search_result).not_to include(edinburgh)
      end

      context 'when position is ignored' do
        let(:search_result) { described_class.search(point, lot_id:, radius:) }

        it 'includes nearby branches' do
          expect(search_result).to include(london_1, london_2)
        end

        it 'excludes far away branches' do
          expect(search_result).not_to include(edinburgh)
        end
      end
    end

    context 'when there are branches outside of the search area' do
      let!(:branch_within_search_area) do
        create(
          :supplier_framework_lot_branch,
          supplier_framework_lot: supplier_framework_lot,
          location: Geocoding.point(latitude: 51.5172265, longitude: -0.1275961)
        )
      end

      let!(:branch_outside_search_area) do
        create(
          :supplier_framework_lot_branch,
          supplier_framework_lot: supplier_framework_lot,
          location: Geocoding.point(latitude: 50.7230521, longitude: -2.0430911)
        )
      end

      let(:position_id) { "#{lot_id}.10" }
      let(:point) { Geocoding.point(latitude: 51.5, longitude: 0) }

      before { create(:supplier_framework_lot_rate, supplier_framework_lot:, position_id:) }

      it 'includes branches within 25 miles' do
        expect(search_result).to include(branch_within_search_area)
      end

      it 'excludes branches outside 25 miles' do
        expect(search_result).not_to include(branch_outside_search_area)
      end

      context 'when position is ignored' do
        let(:search_result) { described_class.search(point, lot_id:, radius:) }

        it 'includes branches within 25 miles' do
          expect(search_result).to include(branch_within_search_area)
        end

        it 'excludes branches outside 25 miles' do
          expect(search_result).not_to include(branch_outside_search_area)
        end
      end
    end

    context 'when there are suppliers without nominated worker rates' do
      let!(:branch_with_nominated_worker_rates) do
        supplier_framework = create(:supplier_framework, framework_id:)
        supplier_framework_lot = create(:supplier_framework_lot, supplier_framework:, lot_id:)

        create(:supplier_framework_lot_rate, supplier_framework_lot:, position_id:)

        create(
          :supplier_framework_lot_branch,
          supplier_framework_lot: supplier_framework_lot,
          location: Geocoding.point(latitude: 0, longitude: 0)
        )
      end
      let!(:branch_with_no_nominated_worker_rates) do
        supplier_framework = create(:supplier_framework, framework_id:)
        supplier_framework_lot = create(:supplier_framework_lot, supplier_framework:, lot_id:)

        create(:supplier_framework_lot_rate, supplier_framework_lot: supplier_framework_lot, position_id: "#{lot_id}.1")

        create(
          :supplier_framework_lot_branch,
          supplier_framework_lot: supplier_framework_lot,
          location: Geocoding.point(latitude: 0, longitude: 0)
        )
      end
      let!(:branch_with_master_vendor_nominated_worker_rate) do
        supplier_framework = create(:supplier_framework, framework_id:)
        supplier_framework_lot = create(:supplier_framework_lot, supplier_framework: supplier_framework, lot_id: 'RM6238.2.1')

        create(:supplier_framework_lot_rate, supplier_framework_lot:, position_id:)

        create(
          :supplier_framework_lot_branch,
          supplier_framework_lot: supplier_framework_lot,
          location: Geocoding.point(latitude: 0, longitude: 0)
        )
      end

      let(:position_id) { "#{lot_id}.10" }
      let(:point) { Geocoding.point(latitude: 0, longitude: 0) }

      it 'includes suppliers that have nominated worker rates' do
        expect(search_result).to include(branch_with_nominated_worker_rates)
      end

      it "excludes suppliers that don't have nominated worker rates" do
        expect(search_result).not_to include(branch_with_no_nominated_worker_rates)
      end

      it "excludes suppliers that don't have nominated worker rates for direct provision" do
        expect(search_result).not_to include(branch_with_master_vendor_nominated_worker_rate)
      end

      context 'when position is ignored' do
        let(:search_result) { described_class.search(point, lot_id:, radius:) }

        it 'includes suppliers that have nominated worker rates' do
          expect(search_result).to include(branch_with_nominated_worker_rates)
        end

        it "includes suppliers that don't have nominated worker rates" do
          expect(search_result).to include(branch_with_no_nominated_worker_rates)
        end

        it "excludes suppliers that don't have nominated worker rates for direct provision" do
          expect(search_result).not_to include(branch_with_master_vendor_nominated_worker_rate)
        end
      end
    end

    context 'when there are suppliers with fixed term rates' do
      let!(:branch_with_fixed_term_rates) do
        supplier_framework = create(:supplier_framework, framework_id:)
        supplier_framework_lot = create(:supplier_framework_lot, supplier_framework:, lot_id:)

        create(:supplier_framework_lot_rate, supplier_framework_lot:, position_id:)

        create(
          :supplier_framework_lot_branch,
          supplier_framework_lot: supplier_framework_lot,
          location: Geocoding.point(latitude: 0, longitude: 0)
        )
      end
      let!(:branch_with_no_fixed_term_rates) do
        supplier_framework = create(:supplier_framework, framework_id:)
        supplier_framework_lot = create(:supplier_framework_lot, supplier_framework:, lot_id:)

        create(:supplier_framework_lot_rate, supplier_framework_lot: supplier_framework_lot, position_id: "#{lot_id}.1")

        create(
          :supplier_framework_lot_branch,
          supplier_framework_lot: supplier_framework_lot,
          location: Geocoding.point(latitude: 0, longitude: 0)
        )
      end
      let!(:branch_with_master_vendor_fixed_term_rate) do
        supplier_framework = create(:supplier_framework, framework_id:)
        supplier_framework_lot = create(:supplier_framework_lot, supplier_framework: supplier_framework, lot_id: 'RM6238.2.1')

        create(:supplier_framework_lot_rate, supplier_framework_lot:, position_id:)

        create(
          :supplier_framework_lot_branch,
          supplier_framework_lot: supplier_framework_lot,
          location: Geocoding.point(latitude: 0, longitude: 0)
        )
      end

      let(:position_id) { "#{lot_id}.11" }
      let(:point) { Geocoding.point(latitude: 0, longitude: 0) }

      it 'includes suppliers that have fixed term rates' do
        expect(search_result).to include(branch_with_fixed_term_rates)
      end

      it "excludes suppliers that don't have fixed term rates" do
        expect(search_result).not_to include(branch_with_no_fixed_term_rates)
      end

      it "excludes suppliers that don't have fixed term rates for direct provision" do
        expect(search_result).not_to include(branch_with_master_vendor_fixed_term_rate)
      end

      context 'when position is ignored' do
        let(:search_result) { described_class.search(point, lot_id:, radius:) }

        it 'includes suppliers that have fixed term rates' do
          expect(search_result).to include(branch_with_fixed_term_rates)
        end

        it "includes suppliers that don't have fixed term rates" do
          expect(search_result).to include(branch_with_no_fixed_term_rates)
        end

        it "excludes suppliers that don't have fixed term rates for direct provision" do
          expect(search_result).not_to include(branch_with_master_vendor_fixed_term_rate)
        end
      end
    end

    context 'when there are suppliers with different nominated worker rates' do
      let!(:branch_of_cheaper_supplier) do
        supplier_framework = create(:supplier_framework, framework_id:)
        supplier_framework_lot = create(:supplier_framework_lot, supplier_framework:, lot_id:)

        create(:supplier_framework_lot_rate, supplier_framework_lot: supplier_framework_lot, position_id: position_id, rate: 1000)

        create(
          :supplier_framework_lot_branch,
          supplier_framework_lot: supplier_framework_lot,
          location: Geocoding.point(latitude: 0, longitude: 0)
        )
      end
      let!(:branch_of_costlier_supplier) do
        supplier_framework = create(:supplier_framework, framework_id:)
        supplier_framework_lot = create(:supplier_framework_lot, supplier_framework:, lot_id:)

        create(:supplier_framework_lot_rate, supplier_framework_lot: supplier_framework_lot, position_id: position_id, rate: 9000)

        create(
          :supplier_framework_lot_branch,
          supplier_framework_lot: supplier_framework_lot,
          location: Geocoding.point(latitude: 0, longitude: 0)
        )
      end

      let(:point) { Geocoding.point(latitude: 0, longitude: 0) }

      it 'orders branches by markup rate in ascending order' do
        expect(search_result).to eq([branch_of_cheaper_supplier, branch_of_costlier_supplier])
      end
    end

    context 'when there are suppliers with different rates in different locations' do
      let!(:branch_of_cheapest_supplier) do
        supplier_framework = create(:supplier_framework, framework_id:)
        supplier_framework_lot = create(:supplier_framework_lot, supplier_framework:, lot_id:)

        create(:supplier_framework_lot_rate, supplier_framework_lot: supplier_framework_lot, position_id: position_id, rate: 0)

        create(
          :supplier_framework_lot_branch,
          supplier_framework_lot: supplier_framework_lot,
          location: Geocoding.point(latitude: 0.2, longitude: 0.2)
        )
      end
      let!(:branch_of_farthest_supplier) do
        supplier_framework = create(:supplier_framework, framework_id:)
        supplier_framework_lot = create(:supplier_framework_lot, supplier_framework:, lot_id:)

        create(:supplier_framework_lot_rate, supplier_framework_lot: supplier_framework_lot, position_id: position_id, rate: 1000)

        create(
          :supplier_framework_lot_branch,
          supplier_framework_lot: supplier_framework_lot,
          location: Geocoding.point(latitude: 0.1, longitude: 0.1)
        )
      end
      let!(:branch_of_closest_supplier) do
        supplier_framework = create(:supplier_framework, framework_id:)
        supplier_framework_lot = create(:supplier_framework_lot, supplier_framework:, lot_id:)

        create(:supplier_framework_lot_rate, supplier_framework_lot: supplier_framework_lot, position_id: position_id, rate: 1000)

        create(
          :supplier_framework_lot_branch,
          supplier_framework_lot: supplier_framework_lot,
          location: Geocoding.point(latitude: 0, longitude: 0)
        )
      end

      let(:point) { Geocoding.point(latitude: 0, longitude: 0) }

      it 'orders branches by mark-up and then proximity in ascending order' do
        expect(search_result).to eq([branch_of_cheapest_supplier, branch_of_closest_supplier, branch_of_farthest_supplier])
      end
    end
  end

  describe '.address_elements' do
    let(:result) { supplier_framework_lot_branch.address_elements }

    before do
      supplier_framework_lot_branch.update(
        address_line_1: 'The first address line',
        address_line_2: address_line_2,
        town: 'The town',
        county: county,
        postcode: 'postcode'
      )
    end

    context 'when all elements are present' do
      let(:address_line_2) { 'The second address line' }
      let(:county) { 'The county' }

      it 'returns all the elemements' do
        expect(result).to eq [
          'The first address line',
          'The second address line',
          'The town',
          'The county',
          'postcode'
        ]
      end
    end

    context 'when some elements are present' do
      let(:address_line_2) { '' }
      let(:county) { nil }

      it 'returns just the present elements' do
        expect(result).to eq [
          'The first address line',
          'The town',
          'postcode'
        ]
      end
    end
  end

  # rubocop:disable RSpec/NestedGroups
  describe 'validations' do
    before do
      supplier_framework_lot_branch.assign_attributes(attributes)

      Geocoder::Lookup::Test.add_stub(
        postcode, [{ 'coordinates' => [51.5201, -0.0759] }],
      )
      Geocoder::Lookup::Test.add_stub(
        'SW1 1AA', [{ 'coordinates' => [51.5201, -0.0759] }],
      )
    end

    after do
      Geocoder::Lookup::Test.reset
    end

    let(:attributes) { { name:, region:, contact_name:, contact_email:, telephone_number:, address_line_1:, address_line_2:, town:, county:, postcode: } }

    let(:name) { Faker::Name.unique.name }
    let(:region) { Faker::Address.state }
    let(:contact_name) { Faker::Name.unique.name }
    let(:contact_email) { Faker::Internet.unique.email }
    let(:telephone_number) { '07700 900000' }
    let(:address_line_1) { Faker::Address.street_address }
    let(:address_line_2) { Faker::Address.secondary_address }
    let(:town) { Faker::Address.city }
    let(:county) { Faker::Address.state }
    let(:postcode) { Faker::Address.unique.postcode }

    context 'when considering the name' do
      context 'and it is nil' do
        let(:name) { nil }

        it 'is invalid and has the correct error message' do
          expect(supplier_framework_lot_branch.valid?(:branches)).to be(false)
          expect(supplier_framework_lot_branch.errors[:name].first).to eq('The branch name cannot be blank')
        end
      end

      context 'and it is blank' do
        let(:name) { '' }

        it 'is invalid and has the correct error message' do
          expect(supplier_framework_lot_branch.valid?(:branches)).to be(false)
          expect(supplier_framework_lot_branch.errors[:name].first).to eq('The branch name cannot be blank')
        end
      end

      context 'and it is too long' do
        let(:name) { 'a' * 256 }

        it 'is invalid and has the correct error message' do
          expect(supplier_framework_lot_branch.valid?(:branches)).to be(false)
          expect(supplier_framework_lot_branch.errors[:name].first).to eq('The branch name must be no more than 255 characters')
        end
      end

      context 'and it is present' do
        context 'and it has excess white space' do
          let(:name) { '     I am the name     ' }

          it 'is valid and removes the excess white space' do
            expect(supplier_framework_lot_branch).to be_valid(:branches)
            expect(supplier_framework_lot_branch.name).to eq('I am the name')
          end
        end

        it 'is valid' do
          expect(supplier_framework_lot_branch).to be_valid(:branches)
        end
      end
    end

    context 'when considering the region' do
      context 'and it is nil' do
        let(:region) { nil }

        it 'is invalid and has the correct error message' do
          expect(supplier_framework_lot_branch.valid?(:branches)).to be(false)
          expect(supplier_framework_lot_branch.errors[:region].first).to eq('The branch region cannot be blank')
        end
      end

      context 'and it is blank' do
        let(:region) { '' }

        it 'is invalid and has the correct error message' do
          expect(supplier_framework_lot_branch.valid?(:branches)).to be(false)
          expect(supplier_framework_lot_branch.errors[:region].first).to eq('The branch region cannot be blank')
        end
      end

      context 'and it is too long' do
        let(:region) { 'a' * 256 }

        it 'is invalid and has the correct error message' do
          expect(supplier_framework_lot_branch.valid?(:branches)).to be(false)
          expect(supplier_framework_lot_branch.errors[:region].first).to eq('The branch region must be no more than 255 characters')
        end
      end

      context 'and it is present' do
        context 'and it has excess white space' do
          let(:region) { '     I am the region     ' }

          it 'is valid and removes the excess white space' do
            expect(supplier_framework_lot_branch).to be_valid(:branches)
            expect(supplier_framework_lot_branch.region).to eq('I am the region')
          end
        end

        it 'is valid' do
          expect(supplier_framework_lot_branch).to be_valid(:branches)
        end
      end
    end

    context 'when considering the contact name' do
      context 'and it is nil' do
        let(:contact_name) { nil }

        it 'is invalid and has the correct error message' do
          expect(supplier_framework_lot_branch.valid?(:branches)).to be(false)
          expect(supplier_framework_lot_branch.errors[:contact_name].first).to eq('The contact name cannot be blank')
        end
      end

      context 'and it is blank' do
        let(:contact_name) { '' }

        it 'is invalid and has the correct error message' do
          expect(supplier_framework_lot_branch.valid?(:branches)).to be(false)
          expect(supplier_framework_lot_branch.errors[:contact_name].first).to eq('The contact name cannot be blank')
        end
      end

      context 'and it is too long' do
        let(:contact_name) { 'a' * 256 }

        it 'is invalid and has the correct error message' do
          expect(supplier_framework_lot_branch.valid?(:branches)).to be(false)
          expect(supplier_framework_lot_branch.errors[:contact_name].first).to eq('The contact name must be no more than 255 characters')
        end
      end

      context 'and it is present' do
        context 'and it has excess white space' do
          let(:contact_name) { '     I am the contact name     ' }

          it 'is valid and removes the excess white space' do
            expect(supplier_framework_lot_branch).to be_valid(:branches)
            expect(supplier_framework_lot_branch.contact_name).to eq('I am the contact name')
          end
        end

        it 'is valid' do
          expect(supplier_framework_lot_branch).to be_valid(:branches)
        end
      end
    end

    context 'when considering the contact email' do
      context 'and it is nil' do
        let(:contact_email) { nil }

        it 'is invalid and has the correct error message' do
          expect(supplier_framework_lot_branch.valid?(:branches)).to be(false)
          expect(supplier_framework_lot_branch.errors[:contact_email].first).to eq('Enter the contact email in the correct format, like name@example.com')
        end
      end

      context 'and it is blank' do
        let(:contact_email) { '' }

        it 'is invalid and has the correct error message' do
          expect(supplier_framework_lot_branch.valid?(:branches)).to be(false)
          expect(supplier_framework_lot_branch.errors[:contact_email].first).to eq('Enter the contact email in the correct format, like name@example.com')
        end
      end

      context 'and it is too long' do
        let(:contact_email) { "a@#{'a' * 254}.com" }

        it 'is invalid and has the correct error message' do
          expect(supplier_framework_lot_branch.valid?(:branches)).to be(false)
          expect(supplier_framework_lot_branch.errors[:contact_email].first).to eq('The contact email must be no more than 255 characters')
        end
      end

      context 'and it is not an email' do
        let(:contact_email) { 'a.com' }

        it 'is invalid and has the correct error message' do
          expect(supplier_framework_lot_branch.valid?(:branches)).to be(false)
          expect(supplier_framework_lot_branch.errors[:contact_email].first).to eq('Enter the contact email in the correct format, like name@example.com')
        end
      end

      context 'and it is present' do
        context 'and it has uppercase characters' do
          let(:contact_email) { 'Test@Test.com' }

          it 'is valid and it makes the email lower case' do
            expect(supplier_framework_lot_branch).to be_valid(:branches)
            expect(supplier_framework_lot_branch.contact_email).to eq('test@test.com')
          end
        end

        context 'and it has spaces' do
          let(:contact_email) { '   test@test.com   ' }

          it 'is valid and removes the excess white space' do
            expect(supplier_framework_lot_branch).to be_valid(:branches)
            expect(supplier_framework_lot_branch.contact_email).to eq('test@test.com')
          end
        end

        it 'is valid' do
          expect(supplier_framework_lot_branch).to be_valid(:branches)
        end
      end
    end

    context 'when considering the telephone number' do
      context 'and it is nil' do
        let(:telephone_number) { nil }

        it 'is invalid and has the correct error message' do
          expect(supplier_framework_lot_branch.valid?(:branches)).to be(false)
          expect(supplier_framework_lot_branch.errors[:telephone_number].first).to eq('Enter the phone number in the correct format, like 07700 900000')
        end
      end

      context 'and it is blank' do
        let(:telephone_number) { '' }

        it 'is invalid and has the correct error message' do
          expect(supplier_framework_lot_branch.valid?(:branches)).to be(false)
          expect(supplier_framework_lot_branch.errors[:telephone_number].first).to eq('Enter the phone number in the correct format, like 07700 900000')
        end
      end

      context 'and it is too short' do
        let(:telephone_number) { '1' * 10 }

        it 'is invalid and has the correct error message' do
          expect(supplier_framework_lot_branch.valid?(:branches)).to be(false)
          expect(supplier_framework_lot_branch.errors[:telephone_number].first).to eq('Enter the phone number in the correct format, like 07700 900000')
        end
      end

      context 'and it is too long' do
        let(:telephone_number) { '1' * 16 }

        it 'is invalid and has the correct error message' do
          expect(supplier_framework_lot_branch.valid?(:branches)).to be(false)
          expect(supplier_framework_lot_branch.errors[:telephone_number].first).to eq('Enter the phone number in the correct format, like 07700 900000')
        end
      end

      context 'and it is not a telephonenumber' do
        let(:telephone_number) { 'I am not a telephone number' }

        it 'is invalid and has the correct error message' do
          expect(supplier_framework_lot_branch.valid?(:branches)).to be(false)
          expect(supplier_framework_lot_branch.errors[:telephone_number].first).to eq('Enter the phone number in the correct format, like 07700 900000')
        end
      end

      context 'and it is present' do
        context 'and it has spaces' do
          let(:telephone_number) { '   07123456789   ' }

          it 'is valid and removes the excess white space' do
            expect(supplier_framework_lot_branch).to be_valid(:branches)
            expect(supplier_framework_lot_branch.telephone_number).to eq('07123456789')
          end
        end

        context 'and it is in the format with 1 space' do
          let(:telephone_number) { '01632 960000' }

          it 'is valid and removes the excess white space' do
            expect(supplier_framework_lot_branch).to be_valid(:branches)
            expect(supplier_framework_lot_branch.telephone_number).to eq('01632 960000')
          end
        end

        context 'and it is in the format with 2 spaces' do
          let(:telephone_number) { '020 7946 0000' }

          it 'is valid and removes the excess white space' do
            expect(supplier_framework_lot_branch).to be_valid(:branches)
            expect(supplier_framework_lot_branch.telephone_number).to eq('020 7946 0000')
          end
        end

        it 'is valid' do
          expect(supplier_framework_lot_branch).to be_valid(:branches)
        end
      end
    end

    context 'when considering the address line 1' do
      context 'and it is nil' do
        let(:address_line_1) { nil }

        it 'is invalid and has the correct error message' do
          expect(supplier_framework_lot_branch.valid?(:branches)).to be(false)
          expect(supplier_framework_lot_branch.errors[:address_line_1].first).to eq('Address line 1 cannot be blank')
        end
      end

      context 'and it is blank' do
        let(:address_line_1) { '' }

        it 'is invalid and has the correct error message' do
          expect(supplier_framework_lot_branch.valid?(:branches)).to be(false)
          expect(supplier_framework_lot_branch.errors[:address_line_1].first).to eq('Address line 1 cannot be blank')
        end
      end

      context 'and it is too long' do
        let(:address_line_1) { 'a' * 256 }

        it 'is invalid and has the correct error message' do
          expect(supplier_framework_lot_branch.valid?(:branches)).to be(false)
          expect(supplier_framework_lot_branch.errors[:address_line_1].first).to eq('Address line 1 must be no more than 255 characters')
        end
      end

      context 'and it is present' do
        context 'and it has excess white space' do
          let(:address_line_1) { '     I am the address line 1     ' }

          it 'is valid and removes the excess white space' do
            expect(supplier_framework_lot_branch).to be_valid(:branches)
            expect(supplier_framework_lot_branch.address_line_1).to eq('I am the address line 1')
          end
        end

        it 'is valid' do
          expect(supplier_framework_lot_branch).to be_valid(:branches)
        end
      end
    end

    context 'when considering the address line 2' do
      context 'and it is too long' do
        let(:address_line_2) { 'a' * 256 }

        it 'is invalid and has the correct error message' do
          expect(supplier_framework_lot_branch.valid?(:branches)).to be(false)
          expect(supplier_framework_lot_branch.errors[:address_line_2].first).to eq('Address line 2 must be no more than 255 characters')
        end
      end

      context 'and it is present' do
        context 'and it is nil' do
          let(:address_line_2) { nil }

          it 'is valid' do
            expect(supplier_framework_lot_branch).to be_valid(:branches)
          end
        end

        context 'and it is blank' do
          let(:address_line_2) { '' }

          it 'is valid' do
            expect(supplier_framework_lot_branch).to be_valid(:branches)
          end
        end

        context 'and it has excess white space' do
          let(:address_line_2) { '     I am address line 2     ' }

          it 'is valid and removes the excess white space' do
            expect(supplier_framework_lot_branch).to be_valid(:branches)
            expect(supplier_framework_lot_branch.address_line_2).to eq('I am address line 2')
          end
        end

        it 'is valid' do
          expect(supplier_framework_lot_branch).to be_valid(:branches)
        end
      end
    end

    context 'when considering the town' do
      context 'and it is nil' do
        let(:town) { nil }

        it 'is invalid and has the correct error message' do
          expect(supplier_framework_lot_branch.valid?(:branches)).to be(false)
          expect(supplier_framework_lot_branch.errors[:town].first).to eq('The town cannot be blank')
        end
      end

      context 'and it is blank' do
        let(:town) { '' }

        it 'is invalid and has the correct error message' do
          expect(supplier_framework_lot_branch.valid?(:branches)).to be(false)
          expect(supplier_framework_lot_branch.errors[:town].first).to eq('The town cannot be blank')
        end
      end

      context 'and it is too long' do
        let(:town) { 'a' * 256 }

        it 'is invalid and has the correct error message' do
          expect(supplier_framework_lot_branch.valid?(:branches)).to be(false)
          expect(supplier_framework_lot_branch.errors[:town].first).to eq('The town must be no more than 255 characters')
        end
      end

      context 'and it is present' do
        context 'and it has excess white space' do
          let(:town) { '     I am the town     ' }

          it 'is valid and removes the excess white space' do
            expect(supplier_framework_lot_branch).to be_valid(:branches)
            expect(supplier_framework_lot_branch.town).to eq('I am the town')
          end
        end

        it 'is valid' do
          expect(supplier_framework_lot_branch).to be_valid(:branches)
        end
      end
    end

    context 'when considering the county' do
      context 'and it is too long' do
        let(:county) { 'a' * 256 }

        it 'is invalid and has the correct error message' do
          expect(supplier_framework_lot_branch.valid?(:branches)).to be(false)
          expect(supplier_framework_lot_branch.errors[:county].first).to eq('The county must be no more than 255 characters')
        end
      end

      context 'and it is present' do
        context 'and it is nil' do
          let(:county) { nil }

          it 'is valid' do
            expect(supplier_framework_lot_branch).to be_valid(:branches)
          end
        end

        context 'and it is blank' do
          let(:county) { '' }

          it 'is valid' do
            expect(supplier_framework_lot_branch).to be_valid(:branches)
          end
        end

        context 'and it has excess white space' do
          let(:county) { '     I am the county     ' }

          it 'is valid and removes the excess white space' do
            expect(supplier_framework_lot_branch).to be_valid(:branches)
            expect(supplier_framework_lot_branch.county).to eq('I am the county')
          end
        end

        it 'is valid' do
          expect(supplier_framework_lot_branch).to be_valid(:branches)
        end
      end
    end

    context 'when considering the postcode' do
      context 'and it is nil' do
        let(:postcode) { nil }

        it 'is invalid and has the correct error message' do
          expect(supplier_framework_lot_branch.valid?(:branches)).to be(false)
          expect(supplier_framework_lot_branch.errors[:postcode].first).to eq('The postcode cannot be blank')
        end
      end

      context 'and it is blank' do
        let(:postcode) { '' }

        it 'is invalid and has the correct error message' do
          expect(supplier_framework_lot_branch.valid?(:branches)).to be(false)
          expect(supplier_framework_lot_branch.errors[:postcode].first).to eq('The postcode cannot be blank')
        end
      end

      context 'and it is not a real postcode' do
        let(:postcode) { 'AAA AAA' }

        it 'is invalid and has the correct error message' do
          expect(supplier_framework_lot_branch.valid?(:branches)).to be(false)
          expect(supplier_framework_lot_branch.errors[:postcode].first).to eq('Enter a valid postcode')
        end
      end

      context 'and it is present' do
        context 'and it has excess white space' do
          let(:postcode) { '     SW1 1AA     ' }

          it 'is valid and removes the excess white space' do
            expect(supplier_framework_lot_branch).to be_valid(:branches)
            expect(supplier_framework_lot_branch.postcode).to eq('SW1 1AA')
          end
        end

        it 'is valid' do
          expect(supplier_framework_lot_branch).to be_valid(:branches)
        end
      end
    end
  end

  describe 'geocodes the postcode' do
    let(:postcode) { 'SW1 1AA' }
    let(:result) { supplier_framework_lot_branch.save(context: :branches) }

    before do
      supplier_framework_lot_branch.assign_attributes(postcode:)

      Geocoder::Lookup::Test.add_stub(
        'SW1 1AA', [{ 'coordinates' => [51.5201, -0.0759] }],
      )
      Geocoder::Lookup::Test.add_stub(
        'SW1 1AB', [{ 'coordinates' => [nil, nil] }]
      )
    end

    after do
      Geocoder::Lookup::Test.reset
    end

    context 'when the location cannot be found' do
      let(:postcode) { 'SW1 1AB' }

      it 'does not save and rasies an error' do
        expect(result).to be(false)
        expect(supplier_framework_lot_branch.errors[:postcode].first).to eq('No location could be found for this postcode, make sure it is a real UK postcode')
      end
    end

    context 'when the location search causes an error' do
      before { allow(Geocoding).to receive(:new).and_raise(Geocoder::InvalidRequest) }

      it 'does not save and rasies an error' do
        expect(result).to be(false)
        expect(supplier_framework_lot_branch.errors[:postcode].first).to eq('No location could be found for this postcode, make sure it is a real UK postcode')
      end
    end

    context 'when the location can be found' do
      it 'saves and sets the coordiantes' do
        result
        expect(result).to be(true)
        expect(supplier_framework_lot_branch.location).to eq(
          Geocoding.point(
            latitude: 51.5201,
            longitude: -0.0759
          )
        )
      end
    end
  end
  # rubocop:enable RSpec/NestedGroups
end

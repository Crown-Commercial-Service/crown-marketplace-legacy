require 'rails_helper'

RSpec.describe SupplyTeachers::RM6238::Branch do
  subject(:branch) { build(:supply_teachers_rm6238_branch) }

  let(:model_key) { 'activerecord.errors.models.supply_teachers/rm6238/branch' }

  it { is_expected.to be_valid }

  it 'is not valid if postcode is nil' do
    branch.postcode = nil
    expect(branch).not_to be_valid
  end

  it 'is not valid if postcode is blank' do
    branch.postcode = ''
    expect(branch).not_to be_valid
  end

  it 'is not valid if location is blank' do
    branch.location = nil
    expect(branch).not_to be_valid
  end

  it 'is not valid if telephone_number is blank' do
    branch.telephone_number = ''
    expect(branch).not_to be_valid
  end

  it 'is not valid if contact_name is blank' do
    branch.contact_name = ''
    expect(branch).not_to be_valid
  end

  it 'is not valid if contact_email is blank' do
    branch.contact_email = ''
    expect(branch).not_to be_valid
  end

  context 'when postcode is nonsense' do
    before do
      branch.postcode = 'nonsense'
    end

    it { is_expected.not_to be_valid }

    it 'obtains the error message from an I18n translation' do
      branch.valid?
      expect(branch.errors[:postcode]).to include(
        I18n.t("#{model_key}.attributes.postcode.invalid_postcode")
      )
    end
  end

  describe '.near' do
    context 'when three branches exist in different locations' do
      let!(:london_1) do
        create(
          :supply_teachers_rm6238_branch,
          location: Geocoding.point(latitude: 51.5201, longitude: -0.0759)
        )
      end

      let!(:london_2) do
        create(
          :supply_teachers_rm6238_branch,
          location: Geocoding.point(latitude: 51.5263, longitude: -0.0858)
        )
      end

      let!(:edinburgh) do
        create(
          :supply_teachers_rm6238_branch,
          location: Geocoding.point(latitude: 55.9619, longitude: -3.1953)
        )
      end

      let(:shoreditch) { Geocoding.point(latitude: 51.5255, longitude: -0.0587) }

      let(:nearby_branches) { described_class.near(shoreditch, within_metres: 10000) }

      it 'includes nearby branches' do
        expect(nearby_branches).to include(london_1, london_2)
      end

      it 'excludes far away branches' do
        expect(nearby_branches).not_to include(edinburgh)
      end
    end
  end

  describe '.search' do
    context 'when there are branches outside of the search area' do
      let(:supplier) do
        create(:supply_teachers_rm6238_supplier).tap do |s|
          create(:supply_teachers_rm6238_rate, job_type: 'nominated', supplier: s)
        end
      end

      let!(:branch_within_search_area) do
        create(
          :supply_teachers_rm6238_branch,
          supplier: supplier,
          location: Geocoding.point(latitude: 51.5172265, longitude: -0.1275961)
        )
      end

      let!(:branch_outside_search_area) do
        create(
          :supply_teachers_rm6238_branch,
          supplier: supplier,
          location: Geocoding.point(latitude: 50.7230521, longitude: -2.0430911)
        )
      end
      let(:results) do
        described_class.search(
          Geocoding.point(latitude: 51.5, longitude: 0),
          rates: SupplyTeachers::RM6238::Rate.direct_provision.nominated_worker,
          radius: 25
        ).to_a
      end

      it 'includes branches within 25 miles' do
        expect(results).to include(branch_within_search_area)
      end

      it 'excludes branches outside 25 miles' do
        expect(results).not_to include(branch_outside_search_area)
      end
    end

    context 'when there are suppliers without nominated worker rates' do
      let!(:branch_with_nominated_worker_rates) do
        supplier = create(:supply_teachers_rm6238_supplier)
        create(:supply_teachers_rm6238_rate, job_type: 'nominated', supplier: supplier)
        create(
          :supply_teachers_rm6238_branch,
          supplier: supplier,
          location: Geocoding.point(latitude: 0, longitude: 0)
        )
      end
      let!(:branch_with_no_nominated_worker_rates) do
        supplier = create(:supply_teachers_rm6238_supplier)
        create(
          :supply_teachers_rm6238_branch,
          supplier: supplier,
          location: Geocoding.point(latitude: 0, longitude: 0)
        )
      end
      let!(:branch_with_master_vendor_nominated_worker_rate) do
        supplier = create(:supply_teachers_rm6238_supplier)
        create(:supply_teachers_rm6238_master_vendor_below_threshold_rate, job_type: 'nominated', supplier: supplier)
        create(
          :supply_teachers_rm6238_branch,
          supplier: supplier,
          location: Geocoding.point(latitude: 0, longitude: 0)
        )
      end
      let(:results) do
        described_class.search(
          Geocoding.point(latitude: 0, longitude: 0),
          rates: SupplyTeachers::RM6238::Rate.direct_provision.nominated_worker,
          radius: 25
        ).to_a
      end

      it 'includes suppliers that have nominated worker rates' do
        expect(results).to include(branch_with_nominated_worker_rates)
      end

      it "excludes suppliers that don't have nominated worker rates" do
        expect(results).not_to include(branch_with_no_nominated_worker_rates)
      end

      it "excludes suppliers that don't have nominated worker rates for direct provision" do
        expect(results).not_to include(branch_with_master_vendor_nominated_worker_rate)
      end
    end

    context 'when there are suppliers with fixed term rates' do
      let!(:branch_with_fixed_term_rates) do
        supplier = create(:supply_teachers_rm6238_supplier)
        create(:supply_teachers_rm6238_rate, job_type: 'fixed_term', supplier: supplier)
        create(
          :supply_teachers_rm6238_branch,
          supplier: supplier,
          location: Geocoding.point(latitude: 0, longitude: 0)
        )
      end
      let!(:branch_with_no_fixed_term_rates) do
        supplier = create(:supply_teachers_rm6238_supplier)
        create(
          :supply_teachers_rm6238_branch,
          supplier: supplier,
          location: Geocoding.point(latitude: 0, longitude: 0)
        )
      end
      let!(:branch_with_master_vendor_fixed_term_rate) do
        supplier = create(:supply_teachers_rm6238_supplier)
        create(:supply_teachers_rm6238_master_vendor_above_threshold_rate, job_type: 'fixed_term', supplier: supplier)
        create(
          :supply_teachers_rm6238_branch,
          supplier: supplier,
          location: Geocoding.point(latitude: 0, longitude: 0)
        )
      end
      let(:results) do
        point = Geocoding.point(latitude: 0, longitude: 0)
        described_class.search(
          point,
          rates: SupplyTeachers::RM6238::Rate.direct_provision.fixed_term,
          radius: 25
        ).to_a
      end

      it 'includes suppliers that have fixed term rates' do
        expect(results).to include(branch_with_fixed_term_rates)
      end

      it "excludes suppliers that don't have fixed term rates" do
        expect(results).not_to include(branch_with_no_fixed_term_rates)
      end

      it "excludes suppliers that don't have fixed term rates for direct provision" do
        expect(results).not_to include(branch_with_master_vendor_fixed_term_rate)
      end
    end

    context 'when there are suppliers with different nominated worker rates' do
      let!(:branch_of_cheaper_supplier) do
        supplier = create(:supply_teachers_rm6238_supplier)
        create(:supply_teachers_rm6238_rate, job_type: 'nominated', supplier: supplier, rate: 1000)
        create(:supply_teachers_rm6238_branch, supplier: supplier, location: Geocoding.point(latitude: 0, longitude: 0))
      end
      let!(:branch_of_costlier_supplier) do
        supplier = create(:supply_teachers_rm6238_supplier)
        create(:supply_teachers_rm6238_rate, job_type: 'nominated', supplier: supplier, rate: 9000)
        create(:supply_teachers_rm6238_branch, supplier: supplier, location: Geocoding.point(latitude: 0, longitude: 0))
      end

      it 'orders branches by markup rate in ascending order' do
        results = described_class.search(
          Geocoding.point(latitude: 0, longitude: 0),
          rates: SupplyTeachers::RM6238::Rate.direct_provision.nominated_worker,
          radius: 25
        ).to_a
        expect(results).to eq([branch_of_cheaper_supplier, branch_of_costlier_supplier])
      end
    end

    context 'when there are suppliers with different rates in different locations' do
      let!(:branch_of_cheapest_supplier) do
        supplier = create(:supply_teachers_rm6238_supplier)
        create(:supply_teachers_rm6238_rate, job_type: 'nominated', supplier: supplier, rate: 0)
        location = Geocoding.point(latitude: 0.2, longitude: 0.2)
        create(:supply_teachers_rm6238_branch, name: 'cheapest', supplier: supplier, location: location)
      end
      let!(:branch_of_farthest_supplier) do
        supplier = create(:supply_teachers_rm6238_supplier)
        create(:supply_teachers_rm6238_rate, job_type: 'nominated', supplier: supplier, rate: 1000)
        location = Geocoding.point(latitude: 0.1, longitude: 0.1)
        create(:supply_teachers_rm6238_branch, name: 'farthest', supplier: supplier, location: location)
      end
      let!(:branch_of_closest_supplier) do
        supplier = create(:supply_teachers_rm6238_supplier)
        create(:supply_teachers_rm6238_rate, job_type: 'nominated', supplier: supplier, rate: 1000)
        location = Geocoding.point(latitude: 0, longitude: 0)
        create(:supply_teachers_rm6238_branch, name: 'closest', supplier: supplier, location: location)
      end

      it 'orders branches by mark-up and then proximity in ascending order' do
        results = described_class.search(
          Geocoding.point(latitude: 0, longitude: 0),
          rates: SupplyTeachers::RM6238::Rate.direct_provision.nominated_worker,
          radius: 25
        ).to_a
        expected_order = [branch_of_cheapest_supplier, branch_of_closest_supplier, branch_of_farthest_supplier]
        expect(results).to eq(expected_order)
      end
    end
  end

  describe '.address_elements' do
    let(:result) { branch.address_elements }

    before do
      branch.update(
        address_1: 'The first address line',
        address_2: address_2,
        town: 'The town',
        county: county,
        postcode: 'The postcode'
      )
    end

    context 'when all elements are present' do
      let(:address_2) { 'The second address line' }
      let(:county) { 'The county' }

      it 'returns all the elemements' do
        expect(result).to eq [
          'The first address line',
          'The second address line',
          'The town',
          'The county',
          'The postcode'
        ]
      end
    end

    context 'when some elements are present' do
      let(:address_2) { '' }
      let(:county) { nil }

      it 'returns just the present elements' do
        expect(result).to eq [
          'The first address line',
          'The town',
          'The postcode'
        ]
      end
    end
  end

  shared_context 'and I have suppliers and branches' do
    before do
      ('a'..'z').each do |supplier_name|
        supplier = create(:supply_teachers_rm6238_supplier, name: supplier_name * 3)

        create(:supply_teachers_rm6238_branch, slug: "branch-#{supplier_name}a", supplier: supplier)
        create(:supply_teachers_rm6238_branch, slug: "branch-#{supplier_name}b", supplier: supplier)
      end
    end
  end

  describe '.distinct_suppliers_count' do
    include_context 'and I have suppliers and branches'

    it 'returns the correct number of suppliers' do
      expect(described_class.distinct_suppliers_count).to eq 26
    end
  end

  describe '.distinct_suppliers' do
    include_context 'and I have suppliers and branches'

    let(:page) { nil }
    let(:supplier_names) { described_class.distinct_suppliers({ agency_name:, page: }).map(&:name) }

    context 'when nothing is searched' do
      let(:agency_name) { nil }

      it 'has the first 25 suppliers in the list' do
        expect(supplier_names).to match_array(('a'..'y').map { |letter| letter * 3 })
      end

      context 'when the page param passed is 2' do
        let(:page) { 2 }

        it 'has the first last 1 supplier in the list' do
          expect(supplier_names).to match_array ['zzz']
        end
      end
    end

    context 'when "a" is searched' do
      let(:agency_name) { 'a' }

      it 'has just aaa in the list' do
        expect(supplier_names).to match_array ['aaa']
      end
    end

    context 'when "z" is searched' do
      let(:agency_name) { 'z' }

      it 'has just zzz in the list' do
        expect(supplier_names).to match_array ['zzz']
      end
    end

    context 'when "hello" is searched' do
      let(:agency_name) { 'hello' }

      it 'has no suppliers in the list' do
        expect(supplier_names).to be_empty
      end
    end
  end
end

require 'rails_helper'

RSpec.describe SupplyTeachers::RM6238::Upload do
  describe 'create' do
    let(:branch_name) { 'Head Office' }
    let(:branch_town) { 'Guildford' }
    let(:supplier_name) { Faker::Name.unique.name }
    let(:supplier_id) { SecureRandom.uuid }
    let(:postcode) { Faker::Address.unique.postcode }
    let(:region) { 'South East England' }
    let(:address_1) { Faker::Address.street_address }
    let(:address_2) { Faker::Address.secondary_address }
    let(:county) { 'Surrey' }
    let(:phone_number) { Faker::PhoneNumber.unique.phone_number }
    let(:latitude) { Faker::Address.unique.latitude }
    let(:longitude) { Faker::Address.unique.longitude }
    let(:contact_name) { Faker::Name.unique.name }
    let(:contact_email) { Faker::Internet.unique.email }

    let(:pricing) { [] }

    let(:branches) do
      [
        {
          'branch_name' => branch_name,
          'region' => region,
          'address_1' => address_1,
          'address_2' => address_2,
          'town' => branch_town,
          'county' => county,
          'postcode' => postcode,
          'lat' => latitude,
          'lon' => longitude,
          'telephone' => phone_number,
          'contacts' => [
            {
              'name' => contact_name,
              'email' => contact_email,
            }
          ]
        }
      ]
    end

    let(:suppliers) do
      [
        {
          'supplier_name' => supplier_name,
          'supplier_id' => supplier_id,
          'branches' => branches,
          'pricing' => pricing,
          'master_vendor_contacts' => {
            'name' => 'Mr. Joelle Littel',
            'telephone' => '0800 966090',
            'email' => 'shawnna@ohara.biz'
          },
          'education_technology_platform_contacts' => {
            'name' => 'Ms. Retta Stehr',
            'telephone' => '01677 32220',
            'email' => 'tyree@hoppe.co'
          }
        }
      ]
    end

    let(:valid_postcode) { instance_double(UKPostcode::GeographicPostcode, valid?: true) }

    let(:supplier) { SupplyTeachers::RM6238::Supplier.last }

    context 'when supplier list is empty' do
      let(:suppliers) { [] }

      it 'does not create any suppliers' do
        expect do
          described_class.upload!(suppliers)
        end.not_to change(SupplyTeachers::RM6238::Supplier, :count)
      end
    end

    context 'when supplier does not exist' do
      before do
        allow(UKPostcode).to receive(:parse).and_return(valid_postcode)
      end

      it 'creates record of successful upload' do
        expect do
          described_class.upload!(suppliers)
        end.to change(described_class, :count).by(1)
      end

      it 'creates supplier' do
        expect do
          described_class.upload!(suppliers)
        end.to change(SupplyTeachers::RM6238::Supplier, :count).by(1)
      end

      it 'creates a branch associated with supplier' do
        expect do
          described_class.upload!(suppliers)
        end.to change(SupplyTeachers::RM6238::Branch, :count).by(1)
      end

      context 'when considering the supplier attributes' do
        let(:branch) { supplier.branches.first }

        before { described_class.upload!(suppliers) }

        it 'assigns ID to supplier' do
          expect(supplier.id).to eq(supplier_id)
        end

        it 'assigns attributes to supplier' do
          expect(supplier.name).to eq(supplier_name)
        end

        it 'assigns master vendor contact information' do
          managed_service_provider = SupplyTeachers::RM6238::Supplier.last.managed_service_providers.find_by(lot_number: '2')
          expect(managed_service_provider).to have_attributes(
            contact_name: 'Mr. Joelle Littel',
            telephone_number: '0800 966090',
            contact_email: 'shawnna@ohara.biz'
          )
        end

        it 'assigns education technology platforms contact information' do
          managed_service_provider = SupplyTeachers::RM6238::Supplier.last.managed_service_providers.find_by(lot_number: '4')
          expect(managed_service_provider).to have_attributes(
            contact_name: 'Ms. Retta Stehr',
            telephone_number: '01677 32220',
            contact_email: 'tyree@hoppe.co'
          )
        end

        it 'assigns attributes to the branch' do
          expect(branch.name).to eq(branch_name)
        end

        it 'assigns address_1 and address_2 attributes to the branch' do
          expect(branch.address_1).to eq(address_1)
          expect(branch.address_2).to eq(address_2)
        end

        it 'assigns county and region attributes to the branch' do
          expect(branch.region).to eq(region)
          expect(branch.county).to eq(county)
        end

        it 'assigns town and postcode attributes to the branch' do
          expect(branch.town).to eq(branch_town)
          expect(branch.postcode).to eq(postcode)
        end

        it 'assigns geography-related attributes to the branch' do
          expect(branch.location.latitude).to be_within(1e-6).of(latitude)
          expect(branch.location.longitude).to be_within(1e-6).of(longitude)
        end

        it 'assigns contact-related attributes to the branch' do
          expect(branch.telephone_number).to eq(phone_number)
          expect(branch.contact_name).to eq(contact_name)
          expect(branch.contact_email).to eq(contact_email)
        end
      end

      context 'and supplier has no branches' do
        let(:branches) { [] }

        it 'creates a supplier anyway' do
          expect do
            described_class.upload!(suppliers)
          end.to change(SupplyTeachers::RM6238::Supplier, :count).by(1)
        end
      end

      context 'and supplier has multiple branches' do
        let(:another_postcode) { Faker::Address.unique.postcode }
        let(:branches) do
          [
            {
              'postcode' => postcode,
              'lat' => latitude,
              'lon' => longitude,
              'telephone' => phone_number,
              'contacts' => [
                {
                  'name' => contact_name,
                  'email' => contact_email,
                }
              ]
            },
            {
              'postcode' => another_postcode,
              'lat' => latitude,
              'lon' => longitude,
              'telephone' => phone_number,
              'contacts' => [
                {
                  'name' => contact_name,
                  'email' => contact_email,
                }
              ]
            }
          ]
        end

        it 'creates two branches associated with supplier' do
          expect do
            described_class.upload!(suppliers)
          end.to change(SupplyTeachers::RM6238::Branch, :count).by(2)
        end

        it 'assigns attributes to the branches' do
          described_class.upload!(suppliers)

          branches = supplier.branches
          expect(branches.map(&:postcode)).to include(postcode, another_postcode)
        end
      end

      context 'and supplier has pricing information' do
        let(:pricing) do
          [
            {
              'lot_number' => '1',
              'job_type' => 'nominated',
              'line_no' => 1,
              'fee' => 3500
            },
            {
              'lot_number' => '1',
              'job_type' => 'fixed_term',
              'line_no' => 2,
              'fee' => 3600
            },
            {
              'lot_number' => '1',
              'job_type' => 'teacher',
              'line_no' => 3,
              'term' => 'six_weeks_plus',
              'fee' => 4000
            }
          ]
        end

        before { described_class.upload!(suppliers) }

        it 'adds nominated worker rates to supplier' do
          expect(supplier.rates.direct_provision).to include(
            an_object_having_attributes(
              job_type: 'nominated',
              term: nil,
              rate: 3500
            )
          )
        end

        it 'adds fixed term rates to supplier' do
          expect(supplier.rates.direct_provision).to include(
            an_object_having_attributes(
              job_type: 'fixed_term',
              term: nil,
              rate: 3600
            )
          )
        end

        it 'imports non-nominated rate data' do
          expect(supplier.rates.direct_provision).to include(
            an_object_having_attributes(
              job_type: 'teacher',
              term: 'six_weeks_plus',
              rate: 4000
            )
          )
        end
      end

      context 'and supplier has master vendor rates' do
        let(:pricing) do
          [
            {
              'lot_number' => '2.1',
              'job_type' => 'nominated',
              'line_no' => 1,
              'fee' => 3500
            },
            {
              'lot_number' => '2.1',
              'job_type' => 'fixed_term',
              'line_no' => 2,
              'fee' => 3600
            },
            {
              'lot_number' => '2.1',
              'job_type' => 'teacher',
              'line_no' => 3,
              'term' => 'daily',
              'fee' => 4000
            },
            {
              'lot_number' => '2.2',
              'job_type' => 'nominated',
              'line_no' => 4,
              'fee' => 2345
            },
            {
              'lot_number' => '2.2',
              'job_type' => 'fixed_term',
              'line_no' => 5,
              'fee' => 4567
            },
            {
              'lot_number' => '2.2',
              'job_type' => 'teacher',
              'line_no' => 6,
              'term' => 'six_weeks_plus',
              'fee' => 6789
            }
          ]
        end

        before { described_class.upload!(suppliers) }

        it 'adds nominated worker rates to supplier in lot 2.1' do
          expect(supplier.rates.master_vendor(:below_threshold)).to include(
            an_object_having_attributes(
              job_type: 'nominated',
              term: nil,
              rate: 3500
            )
          )
        end

        it 'adds nominated worker rates to supplier in lot 2.2' do
          expect(supplier.rates.master_vendor(:above_threshold)).to include(
            an_object_having_attributes(
              job_type: 'nominated',
              term: nil,
              rate: 2345
            )
          )
        end

        it 'adds fixed term rates to supplier in lot 2.1' do
          expect(supplier.rates.master_vendor(:below_threshold)).to include(
            an_object_having_attributes(
              job_type: 'fixed_term',
              term: nil,
              rate: 3600
            )
          )
        end

        it 'adds fixed term rates to supplier in lot 2.2' do
          expect(supplier.rates.master_vendor(:above_threshold)).to include(
            an_object_having_attributes(
              job_type: 'fixed_term',
              term: nil,
              rate: 4567
            )
          )
        end

        it 'imports non-nominated rate data in lot 2.1' do
          expect(supplier.rates.master_vendor(:below_threshold)).to include(
            an_object_having_attributes(
              job_type: 'teacher',
              term: 'daily',
              rate: 4000
            )
          )
        end

        it 'imports non-nominated rate data in lot 2.2' do
          expect(supplier.rates.master_vendor(:above_threshold)).to include(
            an_object_having_attributes(
              job_type: 'teacher',
              term: 'six_weeks_plus',
              rate: 6789
            )
          )
        end
      end

      context 'and supplier has education technology platforms pricing information' do
        let(:pricing) do
          [
            {
              'lot_number' => '4',
              'job_type' => 'nominated',
              'line_no' => 1,
              'fee' => 3500
            },
            {
              'lot_number' => '4',
              'job_type' => 'agency_management',
              'line_no' => 2,
              'term' => 'daily',
              'fee' => 3600
            },
            {
              'lot_number' => '4',
              'job_type' => 'agency_management',
              'line_no' => 3,
              'term' => 'six_weeks_plus',
              'fee' => 4000
            }
          ]
        end

        before { described_class.upload!(suppliers) }

        it 'adds nominated worker rates to supplier' do
          expect(supplier.rates.education_technology_platforms).to include(
            an_object_having_attributes(
              job_type: 'nominated',
              term: nil,
              rate: 3500
            )
          )
        end

        it 'adds daily fee rates to supplier' do
          expect(supplier.rates.education_technology_platforms).to include(
            an_object_having_attributes(
              job_type: 'agency_management',
              term: 'daily',
              rate: 3600
            )
          )
        end

        it 'adds long term fee rates to supplier' do
          expect(supplier.rates.education_technology_platforms).to include(
            an_object_having_attributes(
              job_type: 'agency_management',
              term: 'six_weeks_plus',
              rate: 4000
            )
          )
        end
      end
    end

    context 'when suppliers already exist' do
      before do
        allow(UKPostcode).to receive(:parse).and_return(valid_postcode)
      end

      let!(:first_supplier) { create(:supply_teachers_rm6238_supplier) }
      let!(:second_supplier) { create(:supply_teachers_rm6238_supplier) }

      it 'destroys all existing suppliers' do
        described_class.upload!(suppliers)

        expect(SupplyTeachers::RM6238::Supplier.find_by(id: first_supplier.id))
          .to be_nil
        expect(SupplyTeachers::RM6238::Supplier.find_by(id: second_supplier.id))
          .to be_nil
      end

      context 'and data for one supplier is invalid' do
        let(:suppliers) do
          [
            {
              'supplier_name' => '',
            }
          ]
        end

        it 'does not create record of unsuccessful upload' do
          expect do
            ignoring_exception(ActiveRecord::RecordInvalid) do
              described_class.upload!(suppliers)
            end
          end.not_to change(described_class, :count)
        end

        it 'leaves existing data intact' do
          ignoring_exception(ActiveRecord::RecordInvalid) do
            described_class.upload!(suppliers)
          end

          expect(SupplyTeachers::RM6238::Supplier.find_by(id: first_supplier.id))
            .to eq(first_supplier)
          expect(SupplyTeachers::RM6238::Supplier.find_by(id: second_supplier.id))
            .to eq(second_supplier)
        end
      end
    end

    context 'when data for one supplier is invalid' do
      let(:suppliers) do
        [
          {
            'supplier_name' => supplier_name,
          },
          {
            'supplier_name' => '',
          }
        ]
      end

      it 'raises ActiveRecord::RecordInvalid exception' do
        expect do
          described_class.upload!(suppliers)
        end.to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'does not create any suppliers' do
        expect do
          ignoring_exception(ActiveRecord::RecordInvalid) do
            described_class.upload!(suppliers)
          end
        end.not_to change(SupplyTeachers::RM6238::Supplier, :count)
      end
    end

    context 'when data for one suppliers branch is invalid' do
      let(:suppliers) do
        [
          {
            'supplier_name' => supplier_name,
            'branches' => [{ 'postcode' => postcode }]
          },
          {
            'supplier_name' => Faker::Name.unique.name,
            'branches' => [{ 'postcode' => 'NOT A POSTCODE' }]
          }
        ]
      end

      it 'raises ActiveRecord::RecordInvalid exception' do
        expect do
          described_class.upload!(suppliers)
        end.to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'does not create any suppliers' do
        expect do
          ignoring_exception(ActiveRecord::RecordInvalid) do
            described_class.upload!(suppliers)
          end
        end.not_to change(SupplyTeachers::RM6238::Supplier, :count)
      end
    end
  end

  private

  def ignoring_exception(exception)
    yield
  rescue exception
    nil
  end
end

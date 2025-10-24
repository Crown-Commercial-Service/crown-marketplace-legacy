require 'rails_helper'

RSpec.describe SupplyTeachers::RM6238::Admin::Supplier do
  let(:supplier) { create(:supply_teachers_rm6238_admin_supplier) }
  let(:existing_supplier) { create(:supply_teachers_rm6238_admin_supplier) }

  # rubocop:disable RSpec/NestedGroups
  describe 'validations' do
    before { supplier.assign_attributes(attributes) }

    context 'when validating basic_supplier_information' do
      let(:attributes) { { name:, duns_number:, sme: } }

      let(:name) { Faker::Name.unique.name }
      let(:duns_number) { nil }
      let(:sme) { nil }

      context 'when considering the name' do
        context 'and it is nil' do
          let(:name) { nil }

          it 'is invalid and has the correct error message' do
            expect(supplier.valid?(:basic_supplier_information)).to be(false)
            expect(supplier.errors[:name].first).to eq('The supplier name cannot be blank')
          end
        end

        context 'and it is blank' do
          let(:name) { '' }

          it 'is invalid and has the correct error message' do
            expect(supplier.valid?(:basic_supplier_information)).to be(false)
            expect(supplier.errors[:name].first).to eq('The supplier name cannot be blank')
          end
        end

        context 'and it is too long' do
          let(:name) { 'a' * 256 }

          it 'is invalid and has the correct error message' do
            expect(supplier.valid?(:basic_supplier_information)).to be(false)
            expect(supplier.errors[:name].first).to eq('The supplier name must be no more than 255 characters')
          end
        end

        context 'and it is taken' do
          let(:name) { existing_supplier.name }

          it 'is invalid and has the correct error message' do
            expect(supplier.valid?(:basic_supplier_information)).to be(false)
            expect(supplier.errors[:name].first).to eq('The supplier name you entered is already in use by another supplier')
          end
        end

        context 'and it is present' do
          context 'and it has excess white space' do
            let(:name) { '     I am the name     ' }

            it 'is valid and removes the excess white space' do
              expect(supplier).to be_valid(:basic_supplier_information)
              expect(supplier.name).to eq('I am the name')
            end
          end

          it 'is valid' do
            expect(supplier).to be_valid(:basic_supplier_information)
          end
        end
      end
    end
  end
  # rubocop:enable RSpec/NestedGroups
end

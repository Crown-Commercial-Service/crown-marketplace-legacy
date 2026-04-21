require 'rails_helper'

RSpec.describe SupplyTeachers::RM6376::Admin::Supplier do
  let(:supplier) { create(:supply_teachers_rm6376_admin_supplier, :with_additional_details) }
  let(:existing_supplier) { create(:supply_teachers_rm6376_admin_supplier, :with_additional_details) }

  # rubocop:disable RSpec/NestedGroups
  describe 'validations' do
    before { supplier.assign_attributes(attributes) }

    context 'when validating basic_supplier_information' do
      let(:attributes) { { name:, duns_number:, sme:, trading_name:, additional_identifier: } }

      let(:name) { Faker::Name.unique.name }
      let(:duns_number) { nil }
      let(:sme) { nil }
      let(:trading_name) { Faker::Name.unique.name }
      let(:additional_identifier) { SecureRandom.uuid }

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

      context 'when considering the trading name' do
        context 'and it is nil' do
          let(:trading_name) { nil }

          it 'is invalid and has the correct error message' do
            expect(supplier.valid?(:basic_supplier_information)).to be(false)
            expect(supplier.errors[:trading_name].first).to eq('The supplier trading name cannot be blank')
          end
        end

        context 'and it is blank' do
          let(:trading_name) { '' }

          it 'is invalid and has the correct error message' do
            expect(supplier.valid?(:basic_supplier_information)).to be(false)
            expect(supplier.errors[:trading_name].first).to eq('The supplier trading name cannot be blank')
          end
        end

        context 'and it is too long' do
          let(:trading_name) { 'a' * 256 }

          it 'is invalid and has the correct error message' do
            expect(supplier.valid?(:basic_supplier_information)).to be(false)
            expect(supplier.errors[:trading_name].first).to eq('The supplier trading name must be no more than 255 characters')
          end
        end

        context 'and it is taken' do
          let(:trading_name) { existing_supplier.trading_name }

          it 'is invalid and has the correct error message' do
            expect(supplier.valid?(:basic_supplier_information)).to be(false)
            expect(supplier.errors[:trading_name].first).to eq('The supplier trading name you entered is already in use by another supplier')
          end
        end

        context 'and it is present' do
          context 'and it has excess white space' do
            let(:trading_name) { '     I am the trading name     ' }

            it 'is valid and removes the excess white space' do
              expect(supplier).to be_valid(:basic_supplier_information)
              expect(supplier.trading_name).to eq('I am the trading name')
            end
          end

          it 'is valid' do
            expect(supplier).to be_valid(:basic_supplier_information)
          end
        end
      end

      context 'when considering the additional identifier' do
        context 'and it is nil' do
          let(:additional_identifier) { nil }

          it 'is invalid and has the correct error message' do
            expect(supplier.valid?(:basic_supplier_information)).to be(false)
            expect(supplier.errors[:additional_identifier].first).to eq('The additional identifier cannot be blank')
          end
        end

        context 'and it is blank' do
          let(:additional_identifier) { '' }

          it 'is invalid and has the correct error message' do
            expect(supplier.valid?(:basic_supplier_information)).to be(false)
            expect(supplier.errors[:additional_identifier].first).to eq('The additional identifier cannot be blank')
          end
        end

        context 'and it is too long' do
          let(:additional_identifier) { 'a' * 256 }

          it 'is invalid and has the correct error message' do
            expect(supplier.valid?(:basic_supplier_information)).to be(false)
            expect(supplier.errors[:additional_identifier].first).to eq('The additional identifier must be no more than 255 characters')
          end
        end

        context 'and it is taken' do
          let(:additional_identifier) { existing_supplier.additional_identifier }

          it 'is invalid and has the correct error message' do
            expect(supplier.valid?(:basic_supplier_information)).to be(false)
            expect(supplier.errors[:additional_identifier].first).to eq('The additional identifier you entered is already in use by another supplier')
          end
        end

        context 'and it is present' do
          context 'and it has excess white space' do
            let(:additional_identifier) { '     I am the additional identifier     ' }

            it 'is valid and removes the excess white space' do
              expect(supplier).to be_valid(:basic_supplier_information)
              expect(supplier.additional_identifier).to eq('I am the additional identifier')
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

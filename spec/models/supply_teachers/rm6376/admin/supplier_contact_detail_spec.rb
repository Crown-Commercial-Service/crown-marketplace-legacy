require 'rails_helper'

RSpec.describe SupplyTeachers::RM6376::Admin::SupplierContactDetail do
  let(:contact_detail) { create(:supply_teachers_rm6376_admin_supplier_contact_detail) }

  # rubocop:disable RSpec/NestedGroups
  describe 'validations' do
    before { contact_detail.assign_attributes(attributes) }

    context 'when validating additional_supplier_information' do
      let(:attributes) { { managed_service_provider_name:, managed_service_provider_email:, managed_service_provider_telephone: } }

      let(:managed_service_provider_name) { Faker::Name.name }
      let(:managed_service_provider_email) { Faker::Internet.email }
      let(:managed_service_provider_telephone) { Faker::PhoneNumber.cell_phone_in_e164[1..11] }

      context 'when considering the managed service provider name' do
        context 'and it is nil' do
          let(:managed_service_provider_name) { nil }

          it 'is invalid and has the correct error message' do
            expect(contact_detail.valid?(:additional_supplier_information)).to be(false)
            expect(contact_detail.errors[:managed_service_provider_name].first).to eq('Enter the managed service provider contact name')
          end
        end

        context 'and it is blank' do
          let(:managed_service_provider_name) { '' }

          it 'is invalid and has the correct error message' do
            expect(contact_detail.valid?(:additional_supplier_information)).to be(false)
            expect(contact_detail.errors[:managed_service_provider_name].first).to eq('Enter the managed service provider contact name')
          end
        end

        context 'and it is too long' do
          let(:managed_service_provider_name) { 'a' * 256 }

          it 'is invalid and has the correct error message' do
            expect(contact_detail.valid?(:additional_supplier_information)).to be(false)
            expect(contact_detail.errors[:managed_service_provider_name].first).to eq('The managed service provider contact name should be no more than 255 characters')
          end
        end

        context 'and it is present' do
          context 'and it has spaces' do
            let(:managed_service_provider_name) { '   the name   ' }

            it 'is valid and removes the excess white space' do
              expect(contact_detail).to be_valid(:additional_supplier_information)
              expect(contact_detail.managed_service_provider_name).to eq('the name')
            end
          end

          it 'is valid' do
            expect(contact_detail).to be_valid(:additional_supplier_information)
          end
        end
      end

      context 'when considering the managed service provider email' do
        context 'and it is nil' do
          let(:managed_service_provider_email) { nil }

          it 'is invalid and has the correct error message' do
            expect(contact_detail.valid?(:additional_supplier_information)).to be(false)
            expect(contact_detail.errors[:managed_service_provider_email].first).to eq('Enter the managed service provider contact email in the correct format, like name@example.com')
          end
        end

        context 'and it is blank' do
          let(:managed_service_provider_email) { '' }

          it 'is invalid and has the correct error message' do
            expect(contact_detail.valid?(:additional_supplier_information)).to be(false)
            expect(contact_detail.errors[:managed_service_provider_email].first).to eq('Enter the managed service provider contact email in the correct format, like name@example.com')
          end
        end

        context 'and it is too long' do
          let(:managed_service_provider_email) { "a@#{'a' * 254}.com" }

          it 'is invalid and has the correct error message' do
            expect(contact_detail.valid?(:additional_supplier_information)).to be(false)
            expect(contact_detail.errors[:managed_service_provider_email].first).to eq('The managed service provider contact email should be no more than 255 characters')
          end
        end

        context 'and it is not an email' do
          let(:managed_service_provider_email) { 'a.com' }

          it 'is invalid and has the correct error message' do
            expect(contact_detail.valid?(:additional_supplier_information)).to be(false)
            expect(contact_detail.errors[:managed_service_provider_email].first).to eq('Enter the managed service provider contact email in the correct format, like name@example.com')
          end
        end

        context 'and it is present' do
          context 'and it has uppercase characters' do
            let(:managed_service_provider_email) { 'Test@Test.com' }

            it 'is valid and it makes the email lower case' do
              expect(contact_detail).to be_valid(:additional_supplier_information)
              expect(contact_detail.managed_service_provider_email).to eq('test@test.com')
            end
          end

          context 'and it has spaces' do
            let(:managed_service_provider_email) { '   test@test.com   ' }

            it 'is valid and removes the excess white space' do
              expect(contact_detail).to be_valid(:additional_supplier_information)
              expect(contact_detail.managed_service_provider_email).to eq('test@test.com')
            end
          end

          it 'is valid' do
            expect(contact_detail).to be_valid(:additional_supplier_information)
          end
        end
      end

      context 'when considering the managed service provider telephone' do
        context 'and it is nil' do
          let(:managed_service_provider_telephone) { nil }

          it 'is invalid and has the correct error message' do
            expect(contact_detail.valid?(:additional_supplier_information)).to be(false)
            expect(contact_detail.errors[:managed_service_provider_telephone].first).to eq('Enter the managed service provider contact telephone number in the correct format, like 07700 900000')
          end
        end

        context 'and it is blank' do
          let(:managed_service_provider_telephone) { '' }

          it 'is invalid and has the correct error message' do
            expect(contact_detail.valid?(:additional_supplier_information)).to be(false)
            expect(contact_detail.errors[:managed_service_provider_telephone].first).to eq('Enter the managed service provider contact telephone number in the correct format, like 07700 900000')
          end
        end

        context 'and it is too short' do
          let(:managed_service_provider_telephone) { '1' * 10 }

          it 'is invalid and has the correct error message' do
            expect(contact_detail.valid?(:additional_supplier_information)).to be(false)
            expect(contact_detail.errors[:managed_service_provider_telephone].first).to eq('Enter the managed service provider contact telephone number in the correct format, like 07700 900000')
          end
        end

        context 'and it is too long' do
          let(:managed_service_provider_telephone) { '1' * 16 }

          it 'is invalid and has the correct error message' do
            expect(contact_detail.valid?(:additional_supplier_information)).to be(false)
            expect(contact_detail.errors[:managed_service_provider_telephone].first).to eq('Enter the managed service provider contact telephone number in the correct format, like 07700 900000')
          end
        end

        context 'and it is not a telephonenumber' do
          let(:managed_service_provider_telephone) { 'I am not a telephone number' }

          it 'is invalid and has the correct error message' do
            expect(contact_detail.valid?(:additional_supplier_information)).to be(false)
            expect(contact_detail.errors[:managed_service_provider_telephone].first).to eq('Enter the managed service provider contact telephone number in the correct format, like 07700 900000')
          end
        end

        context 'and it is present' do
          context 'and it has spaces' do
            let(:managed_service_provider_telephone) { '   07123456789   ' }

            it 'is valid and removes the excess white space' do
              expect(contact_detail).to be_valid(:additional_supplier_information)
              expect(contact_detail.managed_service_provider_telephone).to eq('07123456789')
            end
          end

          context 'and it is in the format with 1 space' do
            let(:managed_service_provider_telephone) { '01632 960000' }

            it 'is valid and removes the excess white space' do
              expect(contact_detail).to be_valid(:additional_supplier_information)
              expect(contact_detail.managed_service_provider_telephone).to eq('01632 960000')
            end
          end

          context 'and it is in the format with 2 spaces' do
            let(:managed_service_provider_telephone) { '020 7946 0000' }

            it 'is valid and removes the excess white space' do
              expect(contact_detail).to be_valid(:additional_supplier_information)
              expect(contact_detail.managed_service_provider_telephone).to eq('020 7946 0000')
            end
          end

          it 'is valid' do
            expect(contact_detail).to be_valid(:additional_supplier_information)
          end
        end
      end
    end
  end
  # rubocop:enable RSpec/NestedGroups
end

require 'rails_helper'

RSpec.describe LegalPanelForGovernment::RM6360::Admin::SupplierContactDetail do
  let(:contact_detail) { create(:legal_panel_for_government_rm6360_admin_supplier_contact_detail) }

  # rubocop:disable RSpec/NestedGroups
  describe 'validations' do
    before { contact_detail.assign_attributes(attributes) }

    context 'when validating supplier_contact_information' do
      let(:attributes) { { name:, email:, telephone_number:, website: } }

      let(:name) { nil }
      let(:email) { Faker::Internet.email }
      let(:telephone_number) { Faker::PhoneNumber.cell_phone_in_e164[1..11] }
      let(:website) { Faker::Internet.url }

      context 'when considering the email' do
        context 'and it is nil' do
          let(:email) { nil }

          it 'is invalid and has the correct error message' do
            expect(contact_detail.valid?(:supplier_contact_information)).to be(false)
            expect(contact_detail.errors[:email].first).to eq('Enter the contact email in the correct format, like name@example.com')
          end
        end

        context 'and it is blank' do
          let(:email) { '' }

          it 'is invalid and has the correct error message' do
            expect(contact_detail.valid?(:supplier_contact_information)).to be(false)
            expect(contact_detail.errors[:email].first).to eq('Enter the contact email in the correct format, like name@example.com')
          end
        end

        context 'and it is too long' do
          let(:email) { "a@#{'a' * 254}.com" }

          it 'is invalid and has the correct error message' do
            expect(contact_detail.valid?(:supplier_contact_information)).to be(false)
            expect(contact_detail.errors[:email].first).to eq('The contact email should be no more than 255 characters')
          end
        end

        context 'and it is not an email' do
          let(:email) { 'a.com' }

          it 'is invalid and has the correct error message' do
            expect(contact_detail.valid?(:supplier_contact_information)).to be(false)
            expect(contact_detail.errors[:email].first).to eq('Enter the contact email in the correct format, like name@example.com')
          end
        end

        context 'and it is present' do
          context 'and it has uppercase characters' do
            let(:email) { 'Test@Test.com' }

            it 'is valid and it makes the email lower case' do
              expect(contact_detail).to be_valid(:supplier_contact_information)
              expect(contact_detail.email).to eq('test@test.com')
            end
          end

          context 'and it has spaces' do
            let(:email) { '   test@test.com   ' }

            it 'is valid and removes the excess white space' do
              expect(contact_detail).to be_valid(:supplier_contact_information)
              expect(contact_detail.email).to eq('test@test.com')
            end
          end

          it 'is valid' do
            expect(contact_detail).to be_valid(:supplier_contact_information)
          end
        end
      end

      context 'when considering the telephone number' do
        context 'and it is nil' do
          let(:telephone_number) { nil }

          it 'is invalid and has the correct error message' do
            expect(contact_detail.valid?(:supplier_contact_information)).to be(false)
            expect(contact_detail.errors[:telephone_number].first).to eq('Enter the contact telephone number in the correct format, like 07700 900000')
          end
        end

        context 'and it is blank' do
          let(:telephone_number) { '' }

          it 'is invalid and has the correct error message' do
            expect(contact_detail.valid?(:supplier_contact_information)).to be(false)
            expect(contact_detail.errors[:telephone_number].first).to eq('Enter the contact telephone number in the correct format, like 07700 900000')
          end
        end

        context 'and it is too short' do
          let(:telephone_number) { '1' * 10 }

          it 'is invalid and has the correct error message' do
            expect(contact_detail.valid?(:supplier_contact_information)).to be(false)
            expect(contact_detail.errors[:telephone_number].first).to eq('Enter the contact telephone number in the correct format, like 07700 900000')
          end
        end

        context 'and it is too long' do
          let(:telephone_number) { '1' * 16 }

          it 'is invalid and has the correct error message' do
            expect(contact_detail.valid?(:supplier_contact_information)).to be(false)
            expect(contact_detail.errors[:telephone_number].first).to eq('Enter the contact telephone number in the correct format, like 07700 900000')
          end
        end

        context 'and it is not a telephonenumber' do
          let(:telephone_number) { 'I am not a telephone number' }

          it 'is invalid and has the correct error message' do
            expect(contact_detail.valid?(:supplier_contact_information)).to be(false)
            expect(contact_detail.errors[:telephone_number].first).to eq('Enter the contact telephone number in the correct format, like 07700 900000')
          end
        end

        context 'and it is present' do
          context 'and it has spaces' do
            let(:telephone_number) { '   07123456789   ' }

            it 'is valid and removes the excess white space' do
              expect(contact_detail).to be_valid(:supplier_contact_information)
              expect(contact_detail.telephone_number).to eq('07123456789')
            end
          end

          context 'and it is in the format with 1 space' do
            let(:telephone_number) { '01632 960000' }

            it 'is valid and removes the excess white space' do
              expect(contact_detail).to be_valid(:supplier_contact_information)
              expect(contact_detail.telephone_number).to eq('01632 960000')
            end
          end

          context 'and it is in the format with 2 spaces' do
            let(:telephone_number) { '020 7946 0000' }

            it 'is valid and removes the excess white space' do
              expect(contact_detail).to be_valid(:supplier_contact_information)
              expect(contact_detail.telephone_number).to eq('020 7946 0000')
            end
          end

          it 'is valid' do
            expect(contact_detail).to be_valid(:supplier_contact_information)
          end
        end
      end

      context 'when considering the website' do
        context 'and it is nil' do
          let(:website) { nil }

          it 'is invalid and has the correct error message' do
            expect(contact_detail.valid?(:supplier_contact_information)).to be(false)
            expect(contact_detail.errors[:website].first).to eq('Enter the website in the correct format, like https://example.com')
          end
        end

        context 'and it is blank' do
          let(:website) { '' }

          it 'is invalid and has the correct error message' do
            expect(contact_detail.valid?(:supplier_contact_information)).to be(false)
            expect(contact_detail.errors[:website].first).to eq('Enter the website in the correct format, like https://example.com')
          end
        end

        context 'and it is too long' do
          let(:website) { "https://g#{'o' * 255}le.com" }

          it 'is invalid and has the correct error message' do
            expect(contact_detail.valid?(:supplier_contact_information)).to be(false)
            expect(contact_detail.errors[:website].first).to eq('The contact website be no more than 255 characters')
          end
        end

        context 'and it is not a website' do
          let(:website) { 'I am not a website' }

          it 'is invalid and has the correct error message' do
            expect(contact_detail.valid?(:supplier_contact_information)).to be(false)
            expect(contact_detail.errors[:website].first).to eq('Enter the website in the correct format, like https://example.com')
          end
        end

        context 'and it is present' do
          context 'and it has spaces' do
            let(:website) { '   https://example.com   ' }

            it 'is valid and removes the excess white space' do
              expect(contact_detail).to be_valid(:supplier_contact_information)
              expect(contact_detail.website).to eq('https://example.com')
            end
          end

          it 'is valid' do
            expect(contact_detail).to be_valid(:supplier_contact_information)
          end
        end
      end
    end

    context 'when validating additional_supplier_information' do
      let(:attributes) { { address:, lot_1_prospectus_link:, lot_2_prospectus_link:, lot_3_prospectus_link:, lot_4a_prospectus_link:, lot_4b_prospectus_link:, lot_4c_prospectus_link:, lot_5_prospectus_link: } }

      let(:address) { 'B.L.A.D.E Barracks, NLA' }
      let(:lot_1_prospectus_link) { Faker::Internet.url }
      let(:lot_2_prospectus_link) { Faker::Internet.url }
      let(:lot_3_prospectus_link) { Faker::Internet.url }
      let(:lot_4a_prospectus_link) { Faker::Internet.url }
      let(:lot_4b_prospectus_link) { Faker::Internet.url }
      let(:lot_4c_prospectus_link) { Faker::Internet.url }
      let(:lot_5_prospectus_link) { Faker::Internet.url }

      context 'when considering the address' do
        context 'and it is nil' do
          let(:address) { nil }

          it 'is invalid and has the correct error message' do
            expect(contact_detail.valid?(:additional_supplier_information)).to be(false)
            expect(contact_detail.errors[:address].first).to eq('Enter the address')
          end
        end

        context 'and it is blank' do
          let(:address) { '' }

          it 'is invalid and has the correct error message' do
            expect(contact_detail.valid?(:additional_supplier_information)).to be(false)
            expect(contact_detail.errors[:address].first).to eq('Enter the address')
          end
        end

        context 'and it is too long' do
          let(:address) { 'a' * 256 }

          it 'is invalid and has the correct error message' do
            expect(contact_detail.valid?(:additional_supplier_information)).to be(false)
            expect(contact_detail.errors[:address].first).to eq('The address should be no more than 255 characters')
          end
        end

        context 'and it is present' do
          context 'and it has spaces' do
            let(:address) { '   the address   ' }

            it 'is valid and removes the excess white space' do
              expect(contact_detail).to be_valid(:additional_supplier_information)
              expect(contact_detail.address).to eq('the address')
            end
          end

          it 'is valid' do
            expect(contact_detail).to be_valid(:supplieradditional_supplier_information_contact_information)
          end
        end
      end

      context 'when considering the lot 1 prospectus link' do
        context 'and it is too long' do
          let(:lot_1_prospectus_link) { "https://g#{'o' * 255}le.com" }

          it 'is invalid and has the correct error message' do
            expect(contact_detail.valid?(:additional_supplier_information)).to be(false)
            expect(contact_detail.errors[:lot_1_prospectus_link].first).to eq('The lot 1 prospectus link must be no more than 255 characters')
          end
        end

        context 'and it is not a url' do
          let(:lot_1_prospectus_link) { 'I am not a url' }

          it 'is invalid and has the correct error message' do
            expect(contact_detail.valid?(:additional_supplier_information)).to be(false)
            expect(contact_detail.errors[:lot_1_prospectus_link].first).to eq('Enter the lot 1 prospectus link in the correct format, like https://example.com')
          end
        end

        context 'and it is present' do
          context 'and it is nil' do
            let(:lot_1_prospectus_link) { nil }

            it 'is valid' do
              expect(contact_detail).to be_valid(:additional_supplier_information)
            end
          end

          context 'and it is blank' do
            let(:lot_1_prospectus_link) { '' }

            it 'is valid' do
              expect(contact_detail).to be_valid(:additional_supplier_information)
            end
          end

          context 'and it has spaces' do
            let(:lot_1_prospectus_link) { '   https://example.com   ' }

            it 'is valid and removes the excess white space' do
              expect(contact_detail).to be_valid(:additional_supplier_information)
              expect(contact_detail.lot_1_prospectus_link).to eq('https://example.com')
            end
          end

          it 'is valid' do
            expect(contact_detail).to be_valid(:additional_supplier_information)
          end
        end
      end

      context 'when considering the lot 2 prospectus link' do
        context 'and it is too long' do
          let(:lot_2_prospectus_link) { "https://g#{'o' * 255}le.com" }

          it 'is invalid and has the correct error message' do
            expect(contact_detail.valid?(:additional_supplier_information)).to be(false)
            expect(contact_detail.errors[:lot_2_prospectus_link].first).to eq('The lot 2 prospectus link must be no more than 255 characters')
          end
        end

        context 'and it is not a url' do
          let(:lot_2_prospectus_link) { 'I am not a url' }

          it 'is invalid and has the correct error message' do
            expect(contact_detail.valid?(:additional_supplier_information)).to be(false)
            expect(contact_detail.errors[:lot_2_prospectus_link].first).to eq('Enter the lot 2 prospectus link in the correct format, like https://example.com')
          end
        end

        context 'and it is present' do
          context 'and it is nil' do
            let(:lot_2_prospectus_link) { nil }

            it 'is valid' do
              expect(contact_detail).to be_valid(:additional_supplier_information)
            end
          end

          context 'and it is blank' do
            let(:lot_2_prospectus_link) { '' }

            it 'is valid' do
              expect(contact_detail).to be_valid(:additional_supplier_information)
            end
          end

          context 'and it has spaces' do
            let(:lot_2_prospectus_link) { '   https://example.com   ' }

            it 'is valid and removes the excess white space' do
              expect(contact_detail).to be_valid(:additional_supplier_information)
              expect(contact_detail.lot_2_prospectus_link).to eq('https://example.com')
            end
          end

          it 'is valid' do
            expect(contact_detail).to be_valid(:additional_supplier_information)
          end
        end
      end

      context 'when considering the lot 3 prospectus link' do
        context 'and it is too long' do
          let(:lot_3_prospectus_link) { "https://g#{'o' * 255}le.com" }

          it 'is invalid and has the correct error message' do
            expect(contact_detail.valid?(:additional_supplier_information)).to be(false)
            expect(contact_detail.errors[:lot_3_prospectus_link].first).to eq('The lot 3 prospectus link must be no more than 255 characters')
          end
        end

        context 'and it is not a url' do
          let(:lot_3_prospectus_link) { 'I am not a url' }

          it 'is invalid and has the correct error message' do
            expect(contact_detail.valid?(:additional_supplier_information)).to be(false)
            expect(contact_detail.errors[:lot_3_prospectus_link].first).to eq('Enter the lot 3 prospectus link in the correct format, like https://example.com')
          end
        end

        context 'and it is present' do
          context 'and it is nil' do
            let(:lot_3_prospectus_link) { nil }

            it 'is valid' do
              expect(contact_detail).to be_valid(:additional_supplier_information)
            end
          end

          context 'and it is blank' do
            let(:lot_3_prospectus_link) { '' }

            it 'is valid' do
              expect(contact_detail).to be_valid(:additional_supplier_information)
            end
          end

          context 'and it has spaces' do
            let(:lot_3_prospectus_link) { '   https://example.com   ' }

            it 'is valid and removes the excess white space' do
              expect(contact_detail).to be_valid(:additional_supplier_information)
              expect(contact_detail.lot_3_prospectus_link).to eq('https://example.com')
            end
          end

          it 'is valid' do
            expect(contact_detail).to be_valid(:additional_supplier_information)
          end
        end
      end

      context 'when considering the lot 4a prospectus link' do
        context 'and it is too long' do
          let(:lot_4a_prospectus_link) { "https://g#{'o' * 255}le.com" }

          it 'is invalid and has the correct error message' do
            expect(contact_detail.valid?(:additional_supplier_information)).to be(false)
            expect(contact_detail.errors[:lot_4a_prospectus_link].first).to eq('The lot 4a prospectus link must be no more than 255 characters')
          end
        end

        context 'and it is not a url' do
          let(:lot_4a_prospectus_link) { 'I am not a url' }

          it 'is invalid and has the correct error message' do
            expect(contact_detail.valid?(:additional_supplier_information)).to be(false)
            expect(contact_detail.errors[:lot_4a_prospectus_link].first).to eq('Enter the lot 4a prospectus link in the correct format, like https://example.com')
          end
        end

        context 'and it is present' do
          context 'and it is nil' do
            let(:lot_4a_prospectus_link) { nil }

            it 'is valid' do
              expect(contact_detail).to be_valid(:additional_supplier_information)
            end
          end

          context 'and it is blank' do
            let(:lot_4a_prospectus_link) { '' }

            it 'is valid' do
              expect(contact_detail).to be_valid(:additional_supplier_information)
            end
          end

          context 'and it has spaces' do
            let(:lot_4a_prospectus_link) { '   https://example.com   ' }

            it 'is valid and removes the excess white space' do
              expect(contact_detail).to be_valid(:additional_supplier_information)
              expect(contact_detail.lot_4a_prospectus_link).to eq('https://example.com')
            end
          end

          it 'is valid' do
            expect(contact_detail).to be_valid(:additional_supplier_information)
          end
        end
      end

      context 'when considering the lot 4b prospectus link' do
        context 'and it is too long' do
          let(:lot_4b_prospectus_link) { "https://g#{'o' * 255}le.com" }

          it 'is invalid and has the correct error message' do
            expect(contact_detail.valid?(:additional_supplier_information)).to be(false)
            expect(contact_detail.errors[:lot_4b_prospectus_link].first).to eq('The lot 4b prospectus link must be no more than 255 characters')
          end
        end

        context 'and it is not a url' do
          let(:lot_4b_prospectus_link) { 'I am not a url' }

          it 'is invalid and has the correct error message' do
            expect(contact_detail.valid?(:additional_supplier_information)).to be(false)
            expect(contact_detail.errors[:lot_4b_prospectus_link].first).to eq('Enter the lot 4b prospectus link in the correct format, like https://example.com')
          end
        end

        context 'and it is present' do
          context 'and it is nil' do
            let(:lot_4b_prospectus_link) { nil }

            it 'is valid' do
              expect(contact_detail).to be_valid(:additional_supplier_information)
            end
          end

          context 'and it is blank' do
            let(:lot_4b_prospectus_link) { '' }

            it 'is valid' do
              expect(contact_detail).to be_valid(:additional_supplier_information)
            end
          end

          context 'and it has spaces' do
            let(:lot_4b_prospectus_link) { '   https://example.com   ' }

            it 'is valid and removes the excess white space' do
              expect(contact_detail).to be_valid(:additional_supplier_information)
              expect(contact_detail.lot_4b_prospectus_link).to eq('https://example.com')
            end
          end

          it 'is valid' do
            expect(contact_detail).to be_valid(:additional_supplier_information)
          end
        end
      end

      context 'when considering the lot 4c prospectus link' do
        context 'and it is too long' do
          let(:lot_4c_prospectus_link) { "https://g#{'o' * 255}le.com" }

          it 'is invalid and has the correct error message' do
            expect(contact_detail.valid?(:additional_supplier_information)).to be(false)
            expect(contact_detail.errors[:lot_4c_prospectus_link].first).to eq('The lot 4c prospectus link must be no more than 255 characters')
          end
        end

        context 'and it is not a url' do
          let(:lot_4c_prospectus_link) { 'I am not a url' }

          it 'is invalid and has the correct error message' do
            expect(contact_detail.valid?(:additional_supplier_information)).to be(false)
            expect(contact_detail.errors[:lot_4c_prospectus_link].first).to eq('Enter the lot 4c prospectus link in the correct format, like https://example.com')
          end
        end

        context 'and it is present' do
          context 'and it is nil' do
            let(:lot_4c_prospectus_link) { nil }

            it 'is valid' do
              expect(contact_detail).to be_valid(:additional_supplier_information)
            end
          end

          context 'and it is blank' do
            let(:lot_4c_prospectus_link) { '' }

            it 'is valid' do
              expect(contact_detail).to be_valid(:additional_supplier_information)
            end
          end

          context 'and it has spaces' do
            let(:lot_4c_prospectus_link) { '   https://example.com   ' }

            it 'is valid and removes the excess white space' do
              expect(contact_detail).to be_valid(:additional_supplier_information)
              expect(contact_detail.lot_4c_prospectus_link).to eq('https://example.com')
            end
          end

          it 'is valid' do
            expect(contact_detail).to be_valid(:additional_supplier_information)
          end
        end
      end

      context 'when considering the lot 5 prospectus link' do
        context 'and it is too long' do
          let(:lot_5_prospectus_link) { "https://g#{'o' * 255}le.com" }

          it 'is invalid and has the correct error message' do
            expect(contact_detail.valid?(:additional_supplier_information)).to be(false)
            expect(contact_detail.errors[:lot_5_prospectus_link].first).to eq('The lot 5 prospectus link must be no more than 255 characters')
          end
        end

        context 'and it is not a url' do
          let(:lot_5_prospectus_link) { 'I am not a url' }

          it 'is invalid and has the correct error message' do
            expect(contact_detail.valid?(:additional_supplier_information)).to be(false)
            expect(contact_detail.errors[:lot_5_prospectus_link].first).to eq('Enter the lot 5 prospectus link in the correct format, like https://example.com')
          end
        end

        context 'and it is present' do
          context 'and it is nil' do
            let(:lot_5_prospectus_link) { nil }

            it 'is valid' do
              expect(contact_detail).to be_valid(:additional_supplier_information)
            end
          end

          context 'and it is blank' do
            let(:lot_5_prospectus_link) { '' }

            it 'is valid' do
              expect(contact_detail).to be_valid(:additional_supplier_information)
            end
          end

          context 'and it has spaces' do
            let(:lot_5_prospectus_link) { '   https://example.com   ' }

            it 'is valid and removes the excess white space' do
              expect(contact_detail).to be_valid(:additional_supplier_information)
              expect(contact_detail.lot_5_prospectus_link).to eq('https://example.com')
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

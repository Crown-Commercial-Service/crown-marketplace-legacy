require 'rails_helper'

RSpec.describe LegalServices::RM6240::ServiceOffering, type: :model do
  subject(:service_offering) { build(:legal_services_rm6240_full_service_provision_service_offering) }

  it { is_expected.to be_valid }

  # rubocop:disable RSpec/NestedGroups
  describe 'validations' do
    context 'when validating the service code' do
      before { service_offering.assign_attributes(service_code: service_code) }

      context 'and it is blank' do
        let(:service_code) { nil }

        it 'is not valid' do
          expect(service_offering).not_to be_valid
        end
      end

      context 'and it is not in the list of service codes' do
        let(:service_code) { '1.99' }

        it 'is not valid' do
          expect(service_offering).not_to be_valid
        end
      end
    end

    context 'when validating the jurisdiction' do
      before { service_offering.assign_attributes(service_code: service_code, jurisdiction: jurisdiction) }

      context 'and the service requires it' do
        let(:service_code) { '2.1' }

        context 'and it is blank' do
          let(:jurisdiction) { nil }

          it 'is not valid' do
            expect(service_offering).not_to be_valid
          end
        end

        context 'and it is not in the list of jurisdictions' do
          let(:jurisdiction) { 'invalid-jurisdiction' }

          it 'is not valid' do
            expect(service_offering).not_to be_valid
          end
        end
      end

      context 'and service does not require it' do
        let(:service_code) { '3.1' }

        context 'and it is blank' do
          let(:jurisdiction) { nil }

          it 'is valid' do
            expect(service_offering).to be_valid
          end
        end

        context 'and it is not in the list of jurisdictions' do
          let(:jurisdiction) { 'invalid-jurisdiction' }

          it 'is not valid' do
            expect(service_offering).not_to be_valid
          end
        end

        context 'and it is in the list of jurisdictions' do
          let(:jurisdiction) { 'a' }

          it 'is not valid' do
            expect(service_offering).not_to be_valid
          end
        end
      end
    end

    context 'when validating the uniqueness' do
      let(:new_service_offering) do
        build(
          :legal_services_rm6240_service_offering,
          supplier: supplier,
          service_code: service_code,
          jurisdiction: jurisdiction
        )
      end
      let(:supplier) { service_offering.supplier }
      let(:service_code) { service_offering.service_code }
      let(:jurisdiction) { service_offering.jurisdiction }

      before { service_offering.save }

      context 'when the supplier, service_code and jurisdiction are the same' do
        it 'is not valid' do
          expect(new_service_offering).not_to be_valid
        end
      end

      context 'when the supplier is different' do
        let(:supplier) { build(:legal_services_rm6240_supplier) }

        it 'is valid' do
          expect(new_service_offering).to be_valid
        end
      end

      context 'when the service_code is different' do
        let(:service_code) { '1.2' }

        it 'is valid' do
          expect(new_service_offering).to be_valid
        end
      end

      context 'when the jurisdiction is different' do
        let(:jurisdiction) { 'b' }

        it 'is valid' do
          expect(new_service_offering).to be_valid
        end
      end
    end
  end
  # rubocop:enable RSpec/NestedGroups

  describe '.supplier_ids_for_service_codes_and_jurisdiction' do
    let(:result) { described_class.supplier_ids_for_service_codes_and_jurisdiction(service_codes, jurisdiction) }
    let(:supplier1) { create(:legal_services_rm6240_supplier) }
    let(:supplier2) { create(:legal_services_rm6240_supplier) }
    let(:supplier1_id) { supplier1.id }
    let(:supplier2_id) { supplier2.id }
    let(:jurisdiction) { 'a' }

    before do
      create(:legal_services_rm6240_full_service_provision_service_offering, supplier: supplier1)
      create(:legal_services_rm6240_full_service_provision_service_offering, supplier: supplier2)
      create(:legal_services_rm6240_full_service_provision_service_offering, supplier: supplier1, service_code: '1.2', jurisdiction: 'b')
      create(:legal_services_rm6240_full_service_provision_service_offering, supplier: supplier2, service_code: '1.2')
      create(:legal_services_rm6240_transport_rail_service_offering, supplier: supplier2)
    end

    context 'when we pass a single service code' do
      let(:service_codes) { ['1.1'] }

      it 'returns both suppliers' do
        expect(result).to match_array([supplier1_id, supplier2_id])
      end
    end

    context 'when we pass multiple service codes' do
      let(:service_codes) { ['1.1', '1.2'] }

      it 'returns the second supplier' do
        expect(result).to match_array([supplier2_id])
      end
    end

    context 'when we pass service codes neither supplier does' do
      let(:service_codes) { ['2.1'] }

      it 'returns an emoty array' do
        expect(result).to be_empty
      end
    end

    context 'when we pass 3.1 for the service' do
      let(:service_codes) { ['3.1'] }
      let(:jurisdiction) { nil }

      it 'returns the second supplier' do
        expect(result).to match_array([supplier2_id])
      end
    end

    context 'when we pass a different jurisdiction' do
      let(:service_codes) { ['1.2'] }
      let(:jurisdiction) { 'b' }

      it 'returns the first supplier' do
        expect(result).to match_array([supplier1_id])
      end
    end
  end
end

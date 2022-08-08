require 'rails_helper'

RSpec.describe LegalServices::RM6240::Supplier, type: :model do
  subject(:supplier) { build(:legal_services_rm6240_supplier) }

  describe 'validations' do
    before { supplier.name = supplier_name }

    context 'when the supplier name is blank' do
      let(:supplier_name) { '' }

      it 'is not valid' do
        expect(supplier).not_to be_valid
      end
    end

    context 'when the supplier name is present' do
      let(:supplier_name) { supplier.name }

      it 'is valid' do
        expect(supplier).to be_valid
      end
    end
  end

  context 'when destroying the supplier' do
    before { supplier.save! }

    context 'and the supplier has service offerings' do
      let!(:service_offering) { create(:legal_services_rm6240_full_service_provision_service_offering, supplier: supplier) }

      it 'destroys all its service offerings' do
        supplier.destroy!

        expect(LegalServices::RM6240::ServiceOffering.exists?(service_offering.id)).to be false
      end
    end

    context 'and the supplier has rates' do
      let!(:rate) { create(:legal_services_rm6240_full_service_provision_rate, supplier: supplier) }

      it 'destroys all its rates' do
        supplier.destroy!

        expect(LegalServices::RM6240::Rate.exists?(rate.id)).to be false
      end
    end
  end

  describe '#set_service_codes' do
    let(:result) { described_class.set_service_codes(lot_number, %w[1 13 30 50]) }

    context 'when the lot is 1' do
      let(:lot_number) { '1' }

      it 'only returns the the service codes for service numbers that exist in the lot' do
        expect(result).to eq(%w[1.1 1.13 1.30])
      end
    end

    context 'when the lot is 2' do
      let(:lot_number) { '2' }

      it 'only returns the the service codes for service numbers that exist in the lot' do
        expect(result).to eq(%w[2.1 2.13])
      end
    end

    context 'when the lot is 3' do
      let(:lot_number) { '3' }

      it 'only returns the the service codes for service numbers that exist in the lot' do
        expect(result).to eq(%w[3.1])
      end
    end
  end

  describe '#offering_services_in_jurisdiction' do
    let(:result) { described_class.offering_services_in_jurisdiction(lot_number, service_numbers, jurisdiction) }
    let(:supplier1) { create(:legal_services_rm6240_supplier) }
    let(:supplier2) { create(:legal_services_rm6240_supplier) }
    let(:lot_number) { '1' }
    let(:jurisdiction) { 'a' }

    before do
      create(:legal_services_rm6240_full_service_provision_service_offering, supplier: supplier1)
      create(:legal_services_rm6240_full_service_provision_service_offering, supplier: supplier2)
      create(:legal_services_rm6240_full_service_provision_service_offering, supplier: supplier1, service_code: '1.2', jurisdiction: 'b')
      create(:legal_services_rm6240_full_service_provision_service_offering, supplier: supplier2, service_code: '1.2')
      create(:legal_services_rm6240_transport_rail_service_offering, supplier: supplier2)
    end

    context 'when we pass a single service number' do
      let(:service_numbers) { %w[1] }

      it 'returns both suppliers' do
        expect(result).to match_array([supplier1, supplier2])
      end
    end

    context 'when we pass multiple service numbers' do
      let(:service_numbers) { %w[1 2] }

      it 'returns both suppliers once each' do
        expect(result).to match_array([supplier1, supplier2])
      end
    end

    context 'when we pass service numbers neither supplier does' do
      let(:lot_number) { '2' }
      let(:service_numbers) { %w[1] }

      it 'returns an emoty array' do
        expect(result).to be_empty
      end
    end

    context 'when we pass 3 for the lot number and 1 for the service number' do
      let(:lot_number) { '3' }
      let(:service_numbers) { %w[1] }
      let(:jurisdiction) { nil }

      it 'returns the second supplier' do
        expect(result).to match_array([supplier2])
      end
    end

    context 'when we pass a different jurisdiction' do
      let(:service_numbers) { %w[2] }
      let(:jurisdiction) { 'b' }

      it 'returns the first supplier' do
        expect(result).to match_array([supplier1])
      end
    end
  end

  describe 'when the supplier is destroyed' do
    let!(:supplier) { create(:legal_services_rm6240_supplier) }
    let!(:rate) { create(:legal_services_rm6240_full_service_provision_rate, supplier: supplier) }
    let!(:service_offering) { create(:legal_services_rm6240_full_service_provision_service_offering, supplier: supplier) }

    it 'destroys all suppliers' do
      expect(described_class.find_by(id: supplier.id)).to eq supplier

      supplier.destroy!

      expect(described_class.find_by(id: supplier.id)).to be_nil
    end

    it 'destroys all rates' do
      expect(LegalServices::RM6240::Rate.find_by(id: rate.id)).to eq rate

      supplier.destroy!

      expect(LegalServices::RM6240::Rate.find_by(id: rate.id)).to be_nil
    end

    it 'destroys all service offerings' do
      expect(LegalServices::RM6240::ServiceOffering.find_by(id: service_offering.id)).to eq service_offering

      supplier.destroy!

      expect(LegalServices::RM6240::ServiceOffering.find_by(id: service_offering.id)).to be_nil
    end
  end
end

require 'rails_helper'

RSpec.describe ManagementConsultancy::RM6187::Supplier, type: :model do
  subject(:supplier) { build(:management_consultancy_rm6187_supplier) }

  it { is_expected.to be_valid }

  it 'is not valid if name is blank' do
    supplier.name = ''
    expect(supplier).not_to be_valid
  end

  describe '.available_in_lot' do
    let(:supplier1) { create(:management_consultancy_rm6187_supplier, name: 'Supplier 1') }
    let(:supplier2) { create(:management_consultancy_rm6187_supplier, name: 'Supplier 2') }

    before do
      supplier1.service_offerings.create!(lot_number: 'MCF3.1', service_code: 'MCF3.1.1')
      supplier1.service_offerings.create!(lot_number: 'MCF3.1', service_code: 'MCF3.1.2')
      supplier1.service_offerings.create!(lot_number: 'MCF3.4', service_code: 'MCF3.4.1')

      supplier2.service_offerings.create!(lot_number: 'MCF3.2', service_code: 'MCF3.2.1')
      supplier2.service_offerings.create!(lot_number: 'MCF3.3', service_code: 'MCF3.3.1')
      supplier2.service_offerings.create!(lot_number: 'MCF3.4', service_code: 'MCF3.4.1')
    end

    it 'returns suppliers with availability in MCF3 lot 1' do
      expect(described_class.available_in_lot('MCF3.1')).to contain_exactly(supplier1)
    end

    it 'returns suppliers with availability in MCF 3 lot 4' do
      expect(described_class.available_in_lot('MCF3.4')).to contain_exactly(supplier1, supplier2)
    end

    it 'returns suppliers with availability in MCF3 lot 3' do
      expect(described_class.available_in_lot('MCF3.3')).to contain_exactly(supplier2)
    end
  end

  describe '.offering_services' do
    let(:supplier1) { create(:management_consultancy_rm6187_supplier, name: 'Supplier 1') }
    let(:supplier2) { create(:management_consultancy_rm6187_supplier, name: 'Supplier 2') }

    before do
      supplier1.service_offerings.create!(lot_number: 'MCF3.1', service_code: 'MCF3.1.1')
      supplier1.service_offerings.create!(lot_number: 'MCF3.1', service_code: 'MCF3.1.2')
      supplier1.service_offerings.create!(lot_number: 'MCF3.4', service_code: 'MCF3.4.1')

      supplier2.service_offerings.create!(lot_number: 'MCF3.2', service_code: 'MCF3.2.1')
      supplier2.service_offerings.create!(lot_number: 'MCF3.3', service_code: 'MCF3.3.1')
      supplier2.service_offerings.create!(lot_number: 'MCF3.4', service_code: 'MCF3.4.1')
    end

    it 'returns suppliers with availability in lot 1' do
      expect(described_class.offering_services('MCF3.1', ['MCF3.1.1'])).to contain_exactly(supplier1)
      expect(described_class.offering_services('MCF3.1', ['MCF3.1.1', 'MCF3.1.2'])).to contain_exactly(supplier1)
    end

    it 'only returns suppliers that offer all services' do
      expect(described_class.offering_services('MCF3.1', ['MCF3.1.3'])).to be_empty
      expect(described_class.offering_services('MCF3.1', ['MCF3.1.1', 'MCF3.1.3'])).to be_empty
    end

    it 'ignores services when there is a lot mismatch' do
      expect(described_class.offering_services('MCF3.1', ['MCF3.1.1'])).to contain_exactly(supplier1)
      expect(described_class.offering_services('MCF3.3', ['MCF3.2.1'])).to be_empty
    end
  end

  describe '#services_in_lot' do
    let(:supplier) { create(:management_consultancy_rm6187_supplier, name: 'Supplier 1') }

    let(:service_1_1) { ManagementConsultancy::RM6187::Service.find_by(code: 'MCF3.1.1') }
    let(:service_1_2) { ManagementConsultancy::RM6187::Service.find_by(code: 'MCF3.1.2') }
    let(:service_2_1) { ManagementConsultancy::RM6187::Service.find_by(code: 'MCF3.2.1') }

    before do
      supplier.service_offerings.create!(
        lot_number: service_1_1.lot_number,
        service_code: service_1_1.code
      )
      supplier.service_offerings.create!(
        lot_number: service_1_2.lot_number,
        service_code: service_1_2.code
      )
      supplier.service_offerings.create!(
        lot_number: service_2_1.lot_number,
        service_code: service_2_1.code
      )
    end

    it 'returns services in lot 1' do
      expect(supplier.services_in_lot('MCF3.1')).to contain_exactly(service_1_1, service_1_2)
    end

    it 'returns services in lot 2' do
      expect(supplier.services_in_lot('MCF3.2')).to contain_exactly(service_2_1)
    end
  end

  describe 'when the supplier is destroyed' do
    let!(:supplier) { create(:management_consultancy_rm6187_supplier) }
    let!(:rate_card) { create(:management_consultancy_rm6187_rate_card, supplier: supplier) }
    let!(:service_offering) { create(:management_consultancy_rm6187_service_offering, supplier: supplier) }

    it 'destroys all suppliers' do
      expect(described_class.find_by(id: supplier.id)).to eq supplier

      supplier.destroy!

      expect(described_class.find_by(id: supplier.id)).to be_nil
    end

    it 'destroys all rate cards' do
      expect(ManagementConsultancy::RM6187::RateCard.find_by(id: rate_card.id)).to eq rate_card

      supplier.destroy!

      expect(ManagementConsultancy::RM6187::RateCard.find_by(id: rate_card.id)).to be_nil
    end

    it 'destroys all service offerings' do
      expect(ManagementConsultancy::RM6187::ServiceOffering.find_by(id: service_offering.id)).to eq service_offering

      supplier.destroy!

      expect(ManagementConsultancy::RM6187::ServiceOffering.find_by(id: service_offering.id)).to be_nil
    end
  end
end

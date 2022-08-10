require 'rails_helper'

RSpec.describe LegalServices::RM3788::Supplier, type: :model do
  subject(:supplier) { build(:legal_services_rm3788_supplier) }

  it { is_expected.to be_valid }

  it 'is not valid if name is blank' do
    supplier.name = ''
    expect(supplier).not_to be_valid
  end

  describe '.available_in_lot' do
    let(:supplier1) { create(:legal_services_rm3788_supplier, name: 'Supplier 1') }
    let(:supplier2) { create(:legal_services_rm3788_supplier, name: 'Supplier 2') }

    before do
      supplier1.service_offerings.create!(lot_number: '1', service_code: 'WPSLS.1.1')
      supplier1.service_offerings.create!(lot_number: '1', service_code: 'WPSLS.1.2')
      supplier1.service_offerings.create!(lot_number: '2a', service_code: 'WPSLS.2a.1')

      supplier2.service_offerings.create!(lot_number: '2a', service_code: 'WPSLS.2a.1')
      supplier2.service_offerings.create!(lot_number: '3', service_code: 'WPSLS.3.1')
      supplier2.service_offerings.create!(lot_number: '4', service_code: 'WPSLS.4.1')
    end

    it 'returns suppliers with availability in lot 1' do
      expect(described_class.available_in_lot('1')).to contain_exactly(supplier1)
    end

    it 'returns suppliers with availability in lot 2a' do
      expect(described_class.available_in_lot('2a')).to contain_exactly(supplier1, supplier2)
    end

    it 'returns suppliers with availability in lot 3' do
      expect(described_class.available_in_lot('3')).to contain_exactly(supplier2)
    end
  end

  describe '.offering_services' do
    let(:supplier1) { create(:legal_services_rm3788_supplier, name: 'Supplier 1') }
    let(:supplier2) { create(:legal_services_rm3788_supplier, name: 'Supplier 2') }

    before do
      supplier1.service_offerings.create!(lot_number: '1', service_code: 'WPSLS.1.1')
      supplier1.service_offerings.create!(lot_number: '1', service_code: 'WPSLS.1.2')
      supplier1.service_offerings.create!(lot_number: '2a', service_code: 'WPSLS.2a.1')

      supplier2.service_offerings.create!(lot_number: '2a', service_code: 'WPSLS.2a.1')
      supplier2.service_offerings.create!(lot_number: '3', service_code: 'WPSLS.3.1')
      supplier2.service_offerings.create!(lot_number: '4', service_code: 'WPSLS.4.1')
    end

    it 'returns suppliers with availability in lot 1' do
      expect(described_class.offering_services('1', ['WPSLS.1.1'])).to contain_exactly(supplier1)
      expect(described_class.offering_services('1', ['WPSLS.1.1', 'WPSLS.1.2'])).to contain_exactly(supplier1)
    end

    it 'only returns suppliers that offer all services' do
      expect(described_class.offering_services('1', ['WPSLS.1.3'])).to be_empty
      expect(described_class.offering_services('1', ['WPSLS.1.1', 'WPSLS.1.3'])).to be_empty
    end

    it 'ignores services when there is a lot mismatch' do
      expect(described_class.offering_services('1', ['WPSLS.1.1'])).to contain_exactly(supplier1)
      expect(described_class.offering_services('2a', ['WPSLS.1.1'])).to be_empty
    end
  end

  describe '.offering_services_in_regions' do
    let(:supplier1) do
      create(:legal_services_rm3788_supplier, name: 'Supplier 1')
    end
    let(:supplier2) do
      create(:legal_services_rm3788_supplier, name: 'Supplier 2')
    end
    let(:supplier3) do
      create(:legal_services_rm3788_supplier, name: 'Supplier 3')
    end
    let(:supplier4) do
      create(:legal_services_rm3788_supplier, name: 'Supplier 4')
    end
    let(:supplier5) do
      create(:legal_services_rm3788_supplier, name: 'Supplier 5')
    end

    before do
      supplier1.service_offerings.create!(
        lot_number: '3', service_code: 'WPSLS.3.1'
      )
      supplier1.service_offerings.create!(
        lot_number: '4', service_code: 'WPSLS.4.1'
      )
      supplier1.service_offerings.create!(
        lot_number: '2a', service_code: 'WPSLS.2a.1'
      )
      supplier2.service_offerings.create!(
        lot_number: '4', service_code: 'WPSLS.4.1'
      )
      supplier3.service_offerings.create!(
        lot_number: '2a', service_code: 'WPSLS.2a.1'
      )
      supplier4.service_offerings.create!(
        lot_number: '3', service_code: 'WPSLS.3.1'
      )
      supplier1.regional_availabilities.create!(service_code: 'WPSLS.1.1', region_code: 'UKC')
      supplier1.regional_availabilities.create!(service_code: 'WPSLS.1.2', region_code: 'UKC')
      supplier1.regional_availabilities.create!(service_code: 'WPSLS.1.1', region_code: 'UKD')
      supplier2.regional_availabilities.create!(service_code: 'WPSLS.1.2', region_code: 'UKD')
      supplier3.regional_availabilities.create!(service_code: 'WPSLS.1.1', region_code: 'UKD')
      supplier4.regional_availabilities.create!(service_code: 'WPSLS.1.1', region_code: 'UKC')
      supplier5.regional_availabilities.create!(service_code: 'WPSLS.1.4', region_code: 'UKC')
      supplier5.regional_availabilities.create!(service_code: 'WPSLS.1.5', region_code: 'UKC')
      supplier5.regional_availabilities.create!(service_code: 'WPSLS.1.6', region_code: 'UKC')
      supplier5.regional_availabilities.create!(service_code: 'WPSLS.1.4', region_code: 'UKD')
      supplier5.regional_availabilities.create!(service_code: 'WPSLS.1.5', region_code: 'UKD')
      supplier5.regional_availabilities.create!(service_code: 'WPSLS.1.6', region_code: 'UKD')
    end

    it 'returns suppliers with availability in lot 1 for a single region' do
      expect(described_class.offering_services_in_regions('1', ['WPSLS.1.1'], nil, ['UKC']))
        .to contain_exactly(supplier1, supplier4)

      expect(described_class.offering_services_in_regions('1', ['WPSLS.1.2'], nil, ['UKD']))
        .to contain_exactly(supplier2)

      expect(described_class.offering_services_in_regions('1', ['WPSLS.1.1'], nil, ['UKD']))
        .to contain_exactly(supplier1, supplier3)
    end

    it 'returns suppliers with availability in lot 1 for multiple regions' do
      expect(described_class.offering_services_in_regions('1', ['WPSLS.1.1'], nil, ['UKC', 'UKD']))
        .to contain_exactly(supplier1)
    end

    it 'returns suppliers with availability for multiple services in lot 1 for a single region' do
      expect(described_class.offering_services_in_regions('1', ['WPSLS.1.1', 'WPSLS.1.2'], nil, ['UKC']))
        .to contain_exactly(supplier1)
    end

    it 'returns only suppliers who can provide all services in all regions' do
      expect(described_class.offering_services_in_regions('1', ['WPSLS.1.4', 'WPSLS.1.5', 'WPSLS.1.6'], nil, ['UKC', 'UKD']))
        .to contain_exactly(supplier5)
    end

    it 'returns suppliers with availability in lot 2 for the selected jurisdiction' do
      expect(described_class.offering_services_in_regions('2', ['WPSLS.2a.1'], 'a', nil))
        .to contain_exactly(supplier1, supplier3)
    end

    it 'returns suppliers with availability in lot 3' do
      expect(described_class.offering_services_in_regions('3', ['WPSLS.3.1'], nil, nil))
        .to contain_exactly(supplier1, supplier4)
    end

    it 'returns suppliers with availability in lot 4' do
      expect(described_class.offering_services_in_regions('4', ['WPSLS.4.1'], nil, nil))
        .to contain_exactly(supplier1, supplier2)
    end
  end

  describe 'when the supplier is destroyed' do
    let!(:supplier) { create(:legal_services_rm3788_supplier) }
    let!(:regional_availability) { create(:legal_services_rm3788_regional_availability, supplier: supplier, service_code: 'WPSLS.1.1', region_code: 'UKC') }
    let!(:service_offering) { create(:legal_services_rm3788_service_offering, supplier: supplier, lot_number: '3', service_code: 'WPSLS.3.1') }

    it 'destroys all suppliers' do
      expect(described_class.find_by(id: supplier.id)).to eq supplier

      supplier.destroy!

      expect(described_class.find_by(id: supplier.id)).to be_nil
    end

    it 'destroys all regional availabilities' do
      expect(LegalServices::RM3788::RegionalAvailability.find_by(id: regional_availability.id)).to eq regional_availability

      supplier.destroy!

      expect(LegalServices::RM3788::RegionalAvailability.find_by(id: regional_availability.id)).to be_nil
    end

    it 'destroys all service offerings' do
      expect(LegalServices::RM3788::ServiceOffering.find_by(id: service_offering.id)).to eq service_offering

      supplier.destroy!

      expect(LegalServices::RM3788::ServiceOffering.find_by(id: service_offering.id)).to be_nil
    end
  end
end

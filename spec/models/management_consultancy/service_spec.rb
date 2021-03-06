require 'rails_helper'

RSpec.describe ManagementConsultancy::Service, type: :model do
  subject(:services) { described_class.all }

  let(:first_service) { services.first }
  let(:last_service_with_subservices) { services.find { |service| service.code == 'MCF2.4.9' } }
  let(:all_codes) { described_class.all_codes }

  it 'loads services from CSV' do
    expect(services.count).to eq(243)
  end

  it 'populates attributes of first service' do
    expect(first_service.code).to eq('MCF1.2.1')
    expect(first_service.name).to eq('Accounting advice & risk')
    expect(first_service.lot_number).to eq('MCF1.2')
  end

  it 'only has unique codes' do
    expect(all_codes.uniq).to contain_exactly(*all_codes)
  end

  it 'all have names' do
    expect(services.select { |s| s.name.blank? }).to be_empty
  end

  describe '.all_codes' do
    it 'returns codes for all services' do
      expect(all_codes.count).to eq(services.count)
      expect(all_codes.first).to eq(first_service.code)
    end
  end

  describe '.subservices' do
    it 'returns codes for all of a service’s subservices' do
      expect(last_service_with_subservices.subservices.count).to eq(6)
    end
  end
end

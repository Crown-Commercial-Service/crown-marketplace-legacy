require 'rails_helper'

RSpec.describe LegalServices::RM6240::Service, type: :model do
  subject(:services) { described_class.all }

  let(:available_to_central_government) { described_class.where(central_government: true) }
  let(:first_service) { services.first }
  let(:all_service_code) { described_class.all_service_code }

  it 'loads services from CSV' do
    expect(services.count).to eq(56)
  end

  it 'populates attributes of first service' do
    expect(first_service.attributes).to eq(
      {
        lot_number: '1',
        service_number: '1',
        name: 'Administrative and Public Law',
        central_government: true
      }
    )
  end

  it 'only has unique codes' do
    expect(all_service_code.uniq).to contain_exactly(*all_service_code)
  end

  it 'all have names' do
    expect(services.select { |s| s.name.blank? }).to be_empty
  end

  it 'all to say if they are available to central government' do
    expect(services.select { |s| s.central_government.nil? }).to be_empty
  end

  it 'to only have some services available to central government buyers' do
    expect(available_to_central_government.count).to eq(9)
  end

  describe '.all_service_code' do
    it 'returns codes for all services' do
      expect(all_service_code.count).to eq(services.count)
      expect(all_service_code.first).to eq(first_service.service_code)
    end
  end

  describe '.services_for_lot' do
    context 'when selecting from lots 1, 2 or 3' do
      ['1', '2', '3'].each do |lot_number|
        it 'returns the correct services for that lot' do
          selected_lot_services = described_class.where(lot_number: lot_number)

          expect(described_class.services_for_lot(lot_number)).to eq(selected_lot_services)
        end
      end
    end
  end
end

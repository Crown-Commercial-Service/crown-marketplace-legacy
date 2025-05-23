require 'rails_helper'

RSpec.describe ManagementConsultancy::RM6309::Service do
  subject(:services) { described_class.all }

  let(:first_service) { services.first }
  let(:all_codes) { described_class.all_codes }

  it 'loads services from CSV' do
    expect(services.count).to eq(161)
  end

  it 'populates attributes of first service' do
    expect(first_service.code).to eq('MCF4.1.1')
    expect(first_service.name).to eq('Automation')
    expect(first_service.lot_number).to eq('MCF4.1')
  end

  it 'only has unique codes' do
    expect(all_codes.uniq).to match_array(all_codes)
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
end

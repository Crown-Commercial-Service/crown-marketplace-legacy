require 'rails_helper'

RSpec.describe ManagementConsultancy::RM6309::Journey::ChooseServices do
  subject(:step) { described_class.new(services: %w[MFC4.2.1]) }

  let(:model_key) { 'activemodel.errors.models.management_consultancy/rm6309/journey/choose_services' }

  it { is_expected.to be_valid }

  context 'when services does not contain at least 1 code' do
    before do
      step.services = []
    end

    it { is_expected.not_to be_valid }

    it 'obtains the error message from an I18n translation' do
      step.valid?
      expect(step.errors[:services]).to include(
        I18n.t("#{model_key}.attributes.services.too_short")
      )
    end
  end

  describe '#lot' do
    it 'is expected to find the correct lot' do
      lot_number = 'MCF4.2'
      lot = ManagementConsultancy::RM6309::Lot.find_by(number: lot_number)

      expect(step.lot(lot_number)).to eq lot
    end
  end

  describe '#services_for_lot' do
    it 'is expected to find the correct services for the lot' do
      lot_number = 'MFC4.4'
      services = ManagementConsultancy::RM6309::Service.where(lot_number:)

      expect(step.services_for_lot(lot_number)).to eq services
    end
  end

  describe '#service_groups_for_lot' do
    it 'is expected to find the correct services for a normal lot' do
      lot_number = 'MCF4.2'
      services = ManagementConsultancy::RM6309::Service.where(lot_number:)

      expect(step.service_groups_for_lot(lot_number)).to eq([[nil, services.sort_by(&:name)]])
    end

    it 'is expected to find the correct services for lot 10' do
      lot_number = 'MCF4.10'
      services = ManagementConsultancy::RM6309::Service.where(lot_number:)
      primary_services = services[0..6].sort_by(&:name)
      additional_services = services[7..12].sort_by(&:name)
      sector_services = services[13..].sort_by(&:name)

      expect(step.service_groups_for_lot(lot_number)).to eq [
        ['Primary capabilities', primary_services],
        ['Additional capabilities', additional_services],
        ['Sector specialisms', sector_services]
      ]
    end
  end
end

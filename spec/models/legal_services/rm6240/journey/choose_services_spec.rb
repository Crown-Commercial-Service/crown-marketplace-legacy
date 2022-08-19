require 'rails_helper'

RSpec.describe LegalServices::RM6240::Journey::ChooseServices, type: :model do
  subject(:step) { described_class.new(services: services, lot: lot_number) }

  let(:lot_number) { '1' }
  let(:services) { %w[WPSLS.1.3] }

  describe 'validations' do
    context 'when no services are provided' do
      let(:services) { [] }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:services].first).to eq 'Select at least one legal service'
      end
    end

    context 'when a service is provided' do
      it 'is valid' do
        expect(step).to be_valid
      end
    end
  end

  describe '.next_step_class' do
    it 'returns Journey::ChooseJurisdiction' do
      expect(step.next_step_class).to be LegalServices::RM6240::Journey::ChooseJurisdiction
    end
  end

  describe '.permit_list' do
    it 'returns a list of the permitted attributes' do
      expect(described_class.permit_list).to eq [:lot, { services: [] }]
    end
  end

  describe '.permitted_keys' do
    it 'returns a list of the permitted keys' do
      expect(described_class.permitted_keys).to eq %i[lot services]
    end
  end

  describe '.slug' do
    it 'returns choose-services' do
      expect(step.slug).to eq 'choose-services'
    end
  end

  describe '.template' do
    it 'returns journey/choose_services' do
      expect(step.template).to eq 'journey/choose_services'
    end
  end

  describe '.final?' do
    it 'returns false' do
      expect(step.final?).to be false
    end
  end

  describe '.selected_lot' do
    let(:result) { step.selected_lot }

    context 'when the lot exists' do
      let(:lot_number) { '1' }

      it 'returns the lot' do
        expect(result.number).to eq '1'
        expect(result.description).to eq 'Full service provision'
      end
    end

    context 'when the lot does not exist' do
      let(:lot_number) { '4' }

      it 'returns nil' do
        expect(result).to be_nil
      end
    end
  end

  describe '.services_for_lot' do
    let(:result) { step.services_for_lot(lot_number, nil, central_government) }
    let(:central_government) { 'no' }

    context 'when the lot number is 1' do
      context 'and central_government is yes' do
        let(:central_government) { 'yes' }

        it 'returns a list of 40 services' do
          expect(result.length).to eq(40)
        end

        it 'sets the first service is Administrative and Public Law' do
          expect(result.first.code).to eq('1')
          expect(result.first.name).to eq('Administrative and Public Law')
        end
      end

      context 'and central_government is no' do
        it 'returns a list of 40 services' do
          expect(result.length).to eq(40)
        end

        it 'sets the first service is Administrative and Public Law' do
          expect(result.first.code).to eq('1')
          expect(result.first.name).to eq('Administrative and Public Law')
        end
      end
    end

    context 'when the lot number is 2' do
      let(:lot_number) { '2' }

      context 'and central_government is yes' do
        let(:central_government) { 'yes' }

        it 'returns a list of 15 services' do
          expect(result.length).to eq(15)
        end

        it 'sets the first service is Child Law' do
          expect(result.first.code).to eq('3')
          expect(result.first.name).to eq('Child Law')
        end
      end

      context 'and central_government is no' do
        it 'returns a list of 15 services' do
          expect(result.length).to eq(15)
        end

        it 'sets the first service is Child Law' do
          expect(result.first.code).to eq('3')
          expect(result.first.name).to eq('Child Law')
        end
      end
    end
  end
end

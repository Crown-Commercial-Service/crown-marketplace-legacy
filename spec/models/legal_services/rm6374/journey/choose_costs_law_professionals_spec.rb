require 'rails_helper'

RSpec.describe LegalServices::RM6374::Journey::ChooseCostsLawProfessionals do
  subject(:step) { described_class.new }

  describe 'constants' do
    it 'has the correct PROFESSION_OPTIONS' do
      expect(described_class::PROFESSION_OPTIONS).to eq(%w[
                                                          all
                                                          solicitor_more_than_8_years
                                                          solicitor_more_than_4_years
                                                          solicitor_less_than_4_years
                                                          solicitor_paralegal
                                                        ])
    end
  end

  describe 'attributes' do
    it { is_expected.to respond_to(:professions) }
    it { is_expected.to respond_to(:lot_number) }
  end

  describe 'validations' do
    context 'when professions is nil or empty' do
      before { step.professions = [] }

      it 'is not valid' do
        expect(step).not_to be_valid
        expect(step.errors[:professions]).to be_present
      end
    end

    context 'when professions is present' do
      before { step.professions = ['solicitor_more_than_8_years'] }

      it 'is valid' do
        expect(step).to be_valid
      end
    end
  end

  describe '#lot' do
    let(:lot_mock) { instance_double(Lot) }

    before do
      allow(Lot).to receive(:find).with('RM6374.6').and_return(lot_mock)
    end

    it 'finds the hardcoded lot RM6374.6' do
      expect(step.lot).to eq(lot_mock)
    end
  end

  describe '#next_step_class' do
    it 'returns Journey::ChooseCallOffMechanism' do
      expect(step.next_step_class).to eq(LegalServices::RM6374::Journey::ChooseCallOffMechanism)
    end
  end
end

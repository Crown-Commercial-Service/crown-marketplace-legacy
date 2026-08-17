require 'rails_helper'

RSpec.describe LegalServices::RM6374::Journey::ChooseLawProfessionals do
  subject(:step) { described_class.new }

  describe 'constants' do
    it 'has the correct PROFESSION_OPTIONS' do
      expect(described_class::PROFESSION_OPTIONS).to eq(%w[
                                                          all
                                                          partner
                                                          legal_director
                                                          senior
                                                          solicitor
                                                          junior
                                                          trainee
                                                          paralegal
                                                          legal_project_manager
                                                          legal_document_reviewers
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
      before { step.professions = ['partner', 'senior'] }

      it 'is valid' do
        expect(step).to be_valid
      end
    end
  end

  describe '#lot' do
    let(:lot_number) { '2' }
    let(:expected_lot_id) { "RM6374.#{lot_number}" }
    let(:lot_mock) { instance_double(Lot) }

    before do
      step.lot_number = lot_number
      allow(Lot).to receive(:find).with(expected_lot_id).and_return(lot_mock)
    end

    it 'finds the lot using the combined framework and lot number' do
      expect(step.lot).to eq(lot_mock)
    end
  end

  describe '#next_step_class' do
    it 'returns Journey::ChooseCallOffMechanism' do
      expect(step.next_step_class).to eq(LegalServices::RM6374::Journey::ChooseCallOffMechanism)
    end
  end
end

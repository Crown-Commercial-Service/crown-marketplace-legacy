require 'rails_helper'

RSpec.describe LegalServices::RM6374::Journey::AllLegalSpecalisms, type: :model do
  subject(:step) { described_class.new }

  describe 'attributes' do
    it { is_expected.to respond_to(:sector) }
    it { is_expected.to respond_to(:lot_number) }
    it { is_expected.to respond_to(:service_numbers) }

    it 'defaults service_numbers to an empty array' do
      expect(step.service_numbers).to eq([])
    end
  end

  describe 'validations' do
    context 'when service_numbers is empty' do
      before { step.service_numbers = [] }

      it 'is not valid' do
        expect(step).not_to be_valid
        expect(step.errors[:service_numbers]).to include("Please select a minimum of one legal service to continue")
      end
    end

    context 'when service_numbers is present' do
      before { step.service_numbers = ['1', '2'] }

      it 'is valid' do
        expect(step).to be_valid
      end
    end
  end

  describe '#all_legal_specalisms' do
    let(:where_mock) { instance_double(ActiveRecord::Relation) }
    let(:select_mock) { instance_double(ActiveRecord::Relation) }
    let(:distinct_mock) { instance_double(ActiveRecord::Relation) }
    let(:order_mock) { instance_double(ActiveRecord::Relation) }

    before do
      allow(Service).to receive(:where).with('lot_id LIKE ?', 'RM6374.1%').and_return(where_mock)
      allow(where_mock).to receive(:select).with(:name, 'number::integer').and_return(select_mock)
      allow(select_mock).to receive(:distinct).with('number::integer').and_return(distinct_mock)
      allow(distinct_mock).to receive(:order).with('number::integer').and_return(order_mock)
    end

    it 'returns the ordered, distinct list of legal specialisms' do
      expect(step.all_legal_specalisms).to eq(order_mock)
    end
  end

  describe '#next_step_class' do
    let(:sector) { 'central_government' }
    let(:service_numbers) { ['1', '2'] }
    let(:step) { described_class.new(sector: sector, service_numbers: service_numbers) }
    
    before do
      allow(LegalServices::RM6374::Journey::CrossLotCheck).to receive(:evaluate)
        .with(selected_sector: sector, selected_specialisms: service_numbers)
        .and_return(evaluation_result)
    end

    context 'when the CrossLotCheck returns alternatives' do
      let(:evaluation_result) { { alternatives: ['RM6374.2'] } }

      it 'returns Journey::RecommendedLot' do
        expect(step.next_step_class).to eq(LegalServices::RM6374::Journey::RecommendedLot)
      end
    end

    context 'when the CrossLotCheck returns no alternatives' do
      let(:evaluation_result) { { alternatives: [] } }

      it 'returns Journey::ChooseJurisdiction' do
        expect(step.next_step_class).to eq(LegalServices::RM6374::Journey::ChooseJurisdiction)
      end
    end
  end
end
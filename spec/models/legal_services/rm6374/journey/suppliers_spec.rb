require 'rails_helper'

RSpec.describe LegalServices::RM6374::Journey::Suppliers do
  subject(:step) { described_class.new }

  describe 'attributes' do
    it { is_expected.to respond_to(:lot_number) }
  end

  describe '#next_step_class' do
    context "when lot_number is '6'" do
      before { step.lot_number = '6' }

      it 'returns Journey::ChooseCostsLawProfessionals' do
        expect(step.next_step_class).to eq(LegalServices::RM6374::Journey::ChooseCostsLawProfessionals)
      end
    end

    context "when lot_number is not '6'" do
      before { step.lot_number = '1' }

      it 'returns Journey::ChooseLawProfessionals' do
        expect(step.next_step_class).to eq(LegalServices::RM6374::Journey::ChooseLawProfessionals)
      end
    end

    context 'when lot_number is nil' do
      before { step.lot_number = nil }

      it 'returns Journey::ChooseLawProfessionals' do
        expect(step.next_step_class).to eq(LegalServices::RM6374::Journey::ChooseLawProfessionals)
      end
    end
  end
end

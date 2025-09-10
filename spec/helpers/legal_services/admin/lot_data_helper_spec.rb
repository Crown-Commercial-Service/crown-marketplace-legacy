require 'rails_helper'

RSpec.describe LegalServices::Admin::LotDataHelper do
  describe 'services_lot_title' do
    let(:result) { helper.services_lot_title({ lot: { number: number, name: 'Candid and Credible' } }) }

    context 'when the lot ends in a' do
      let(:number) { 'Xa' }

      it 'returns the lot name and number with England and Wales' do
        expect(result).to eq 'Lot Xa - Candid and Credible (England and Wales)'
      end
    end

    context 'when the lot ends in b' do
      let(:number) { 'Xb' }

      it 'returns the lot name and number with Scotland' do
        expect(result).to eq 'Lot Xb - Candid and Credible (Scotland)'
      end
    end

    context 'when the lot ends in c' do
      let(:number) { 'Xc' }

      it 'returns the lot name and number with Northern Ireland' do
        expect(result).to eq 'Lot Xc - Candid and Credible (Northern Ireland)'
      end
    end

    context 'when the lot numbers is 3' do
      let(:number) { '3' }

      it 'returns the lot name and number without jurisdiction' do
        expect(result).to eq 'Lot 3 - Candid and Credible'
      end
    end
  end
end

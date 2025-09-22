require 'rails_helper'

RSpec.describe Admin::LotDataHelper do
  describe 'services_lot_title' do
    let(:result) { helper.services_lot_title({ lot: { number: 'X', name: 'Candid and Credible' } }) }

    it 'returns the lot name and number' do
      expect(result).to eq 'Lot X - Candid and Credible'
    end
  end

  describe 'enabled_status_tag' do
    let(:status_tag) { helper.enabled_status_tag(is_enabled) }

    context 'when the is_enabled is false' do
      let(:is_enabled) { false }

      it 'returns Inactive and red' do
        expect(status_tag).to eq ['Inactive', :red]
      end
    end

    context 'when the is_enabled is true' do
      let(:is_enabled) { true }

      it 'returns Active' do
        expect(status_tag).to eq ['Active']
      end
    end
  end
end

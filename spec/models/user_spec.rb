require 'rails_helper'

RSpec.describe User do
  describe 'associations' do
    it { is_expected.to have_many(:searches) }
    it { is_expected.to have_many(:reports) }
  end

  describe '#confirmed?' do
    subject(:user) { build(:user, confirmed_at:) }

    context 'when confirmed_at blank' do
      let(:confirmed_at) { nil }

      it 'returns false' do
        expect(user.confirmed?).to be false
      end
    end

    context 'when confirmed_at is a date' do
      let(:confirmed_at) { Time.zone.now }

      it 'returns true' do
        expect(user.confirmed?).to be true
      end
    end
  end
end

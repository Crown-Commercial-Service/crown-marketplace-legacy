require 'rails_helper'

RSpec.describe User do
  describe 'associations' do
    it { is_expected.to have_one(:buyer_detail) }
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

  describe '#buyer_details_incomplete?' do
    subject(:user) { build(:user, confirmed_at:) }

    let(:confirmed_at) { Time.zone.now }

    context 'when user is buyer without buyer details' do
      it 'returns true' do
        user.roles = %i[buyer ls_access]
        expect(user.buyer_details_incomplete?).to be true
      end
    end

    context 'when user isn\'t a buyer' do
      it 'returns false' do
        user.roles = %i[ls_access]
        expect(user.buyer_details_incomplete?).to be false
      end
    end

    context 'when user is a buyer and has empty details' do
      it 'returns true' do
        user.roles = %i[buyer ls_access]
        user.buyer_detail = nil
        expect(user.buyer_details_incomplete?).to be true
      end
    end

    context 'when user is a buyer is missing most of the details' do
      it 'returns true' do
        user.roles = %i[buyer ls_access]
        user.buyer_detail = BuyerDetail.new
        user.buyer_detail.name = 'Test name'
        expect(user.buyer_details_incomplete?).to be true
      end
    end

    context 'when user is a buyer and has incomplete details' do
      before do
        user.roles = %i[buyer ls_access]
        user.buyer_detail = BuyerDetail.new
        user.buyer_detail.name = 'Test name'
        user.buyer_detail.job_title = 'Job title'
        user.buyer_detail.organisation_sector = 'defence_and_security'
      end

      it 'returns true' do
        expect(user.buyer_details_incomplete?).to be true
      end
    end

    context 'when user is a buyer and has complete details' do
      before do
        user.roles = %i[buyer ls_access]
        user.buyer_detail = BuyerDetail.new
        user.buyer_detail.name = 'Test name'
        user.buyer_detail.job_title = 'Job title'
        user.buyer_detail.organisation_name = 'org name'
        user.buyer_detail.organisation_sector = 'defence_and_security'
      end

      it 'returns false' do
        expect(user.buyer_details_incomplete?).to be false
      end
    end
  end
end

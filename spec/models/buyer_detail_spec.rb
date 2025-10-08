require 'rails_helper'

RSpec.describe BuyerDetail do
  let(:buyer_detail) { create(:buyer_detail) }

  describe 'associations' do
    it 'has the user relationship' do
      expect(buyer_detail.user).to be_present
    end
  end

  describe '#validations' do
    context 'when everything is present' do
      it 'is valid' do
        expect(buyer_detail.valid?).to be true
      end
    end

    context 'when considering full name' do
      before { buyer_detail.name = name }

      context 'when full name not present' do
        let(:name) { nil }

        it 'is invalid' do
          expect(buyer_detail).not_to be_valid(:update)
          expect(buyer_detail.errors[:name].first).to eq('Enter your full name')
        end
      end

      context 'when full name is more than max characters' do
        let(:name) { 'a' * 256 }

        it 'is invalid' do
          expect(buyer_detail).not_to be_valid(:update)
          expect(buyer_detail.errors[:name].first).to eq('Your name must be no more than 255 characters')
        end
      end
    end

    context 'when considering job title' do
      before { buyer_detail.job_title = job_title }

      context 'when job title not present' do
        let(:job_title) { nil }

        it 'is invalid' do
          expect(buyer_detail).not_to be_valid(:update)
          expect(buyer_detail.errors[:job_title].first).to eq('Enter your job title')
        end
      end

      context 'when job title is more than max characters' do
        let(:job_title) { 'a' * 256 }

        it 'is invalid' do
          expect(buyer_detail).not_to be_valid(:update)
          expect(buyer_detail.errors[:job_title].first).to eq('Your job title must be no more than 255 characters')
        end
      end
    end

    context 'when considering organisation name' do
      before { buyer_detail.organisation_name = organisation_name }

      context 'when organisation name not present' do
        let(:organisation_name) { nil }

        it 'is invalid' do
          expect(buyer_detail).not_to be_valid(:update)
          expect(buyer_detail.errors[:organisation_name].first).to eq('Enter your organisation name')
        end
      end

      context 'when organisation name is more than max characters' do
        let(:organisation_name) { 'a' * 256 }

        it 'is invalid' do
          expect(buyer_detail).not_to be_valid(:update)
          expect(buyer_detail.errors[:organisation_name].first).to eq('Your organisation name must be no more than 255 characters')
        end
      end
    end

    context 'when considering organisation_sector' do
      before { buyer_detail.organisation_sector = organisation_sector }

      context 'and it is blank' do
        let(:organisation_sector) { '' }

        it 'is invalid and has the correct error message' do
          expect(buyer_detail).not_to be_valid(:update)
          expect(buyer_detail.errors[:organisation_sector].first).to eq 'Select the type of public sector organisation you’re buying for'
        end
      end

      context 'and it is nil' do
        let(:organisation_sector) { nil }

        it 'is invalid and has the correct error message' do
          expect(buyer_detail).not_to be_valid(:update)
          expect(buyer_detail.errors[:organisation_sector].first).to eq 'Select the type of public sector organisation you’re buying for'
        end
      end

      context 'and it is not in the list' do
        let(:organisation_sector) { true }

        it 'is invalid and has the correct error message' do
          expect(buyer_detail).not_to be_valid(:update)
          expect(buyer_detail.errors[:organisation_sector].first).to eq 'Select the type of public sector organisation you’re buying for'
        end
      end

      context 'and it is in the list' do
        let(:organisation_sector) { 'government_policy' }

        it 'is valid' do
          expect(buyer_detail).to be_valid(:update)
        end
      end
    end
  end

  describe '#sector_name' do
    let(:result) { buyer_detail.sector_name }

    before { buyer_detail.organisation_sector = organisation_sector }

    context 'when organisation_sector is defence_and_security' do
      let(:organisation_sector) { 'defence_and_security' }

      it 'returns Defence and Security' do
        expect(result).to eq 'Defence and Security'
      end
    end

    context 'when organisation_sector is health' do
      let(:organisation_sector) { 'health' }

      it 'returns Health' do
        expect(result).to eq 'Health'
      end
    end

    context 'when organisation_sector is government_policy' do
      let(:organisation_sector) { 'government_policy' }

      it 'returns Government Policy' do
        expect(result).to eq 'Government Policy'
      end
    end

    context 'when organisation_sector is local_community_and_housing' do
      let(:organisation_sector) { 'local_community_and_housing' }

      it 'returns Local Community and Housing' do
        expect(result).to eq 'Local Community and Housing'
      end
    end

    context 'when organisation_sector is infrastructure' do
      let(:organisation_sector) { 'infrastructure' }

      it 'returns Infrastructure' do
        expect(result).to eq 'Infrastructure'
      end
    end

    context 'when organisation_sector is education' do
      let(:organisation_sector) { 'education' }

      it 'returns Education' do
        expect(result).to eq 'Education'
      end
    end

    context 'when organisation_sector is culture_media_and_sport' do
      let(:organisation_sector) { 'culture_media_and_sport' }

      it 'returns Culture, Media and Sport' do
        expect(result).to eq 'Culture, Media and Sport'
      end
    end
  end

  describe '#details_complete?' do
    context 'when all attributes are there' do
      it 'returns true' do
        expect(buyer_detail.details_complete?).to be(true)
      end
    end

    context 'when some attributes are missing' do
      before { buyer_detail.name = nil }

      it 'returns true' do
        expect(buyer_detail.details_complete?).to be(false)
      end
    end
  end
end

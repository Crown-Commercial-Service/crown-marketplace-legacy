require 'rails_helper'

RSpec.describe LegalServices::RM6240::SuppliersHelper, type: :helper do
  let(:lot_number) { rand(1..3).to_s }
  let(:lot) { LegalServices::RM6240::Lot.find_by(number: lot_number) }

  describe '#full_lot_description' do
    it 'returns the full title with lot and description' do
      expect(helper.full_lot_description(lot.number, lot.description)).to eq("Lot #{lot_number} - #{lot.description}")
    end
  end

  describe '.prospectus_link_present?' do
    before do
      params[:lot] = '1'
      @supplier = create(:legal_services_rm6240_supplier, lot_1_prospectus_link: lot_1_prospectus_link)
    end

    context 'when the link is nil' do
      let(:lot_1_prospectus_link) { nil }

      it 'returns false' do
        expect(helper.prospectus_link_present?).to be false
      end
    end

    context 'when the link is N/A' do
      let(:lot_1_prospectus_link) { 'N/A' }

      it 'returns false' do
        expect(helper.prospectus_link_present?).to be false
      end
    end

    context 'when the link is a link' do
      let(:lot_1_prospectus_link) { Faker::Internet.unique.url }

      it 'returns true' do
        expect(helper.prospectus_link_present?).to be true
      end
    end
  end

  describe '#prospectus_link_a_url?' do
    let(:link_url) { Faker::Internet.unique.url }

    before do
      params[:lot] = lot_number
      @supplier = create(:legal_services_rm6240_supplier, "lot_#{lot_number}_prospectus_link" => link_text)
    end

    context 'when the link is a url' do
      let(:link_text) { link_url }

      it 'returns true' do
        expect(helper.prospectus_link_a_url?).to be true
      end
    end

    context 'when the link is text' do
      let(:link_text) { "Please contuct us though the form at #{link_url}" }

      it 'returns false' do
        expect(helper.prospectus_link_a_url?).to be false
      end
    end
  end

  describe 'prospectus_link' do
    let(:lot_1_prospectus_link) { Faker::Internet.unique.url }
    let(:lot_2_prospectus_link) { Faker::Internet.unique.url }
    let(:lot_3_prospectus_link) { Faker::Internet.unique.url }

    before do
      params[:lot] = lot_number
      @supplier = create(:legal_services_rm6240_supplier, lot_1_prospectus_link: lot_1_prospectus_link, lot_2_prospectus_link: lot_2_prospectus_link, lot_3_prospectus_link: lot_3_prospectus_link)
    end

    context 'when in lot 1' do
      let(:lot_number) { '1' }

      it 'returns lot 1 prospectus link' do
        expect(helper.prospectus_link).to eq lot_1_prospectus_link
      end
    end

    context 'when in lot 2' do
      let(:lot_number) { '2' }

      it 'returns lot 2 prospectus link' do
        expect(helper.prospectus_link).to eq lot_2_prospectus_link
      end
    end

    context 'when in lot 3' do
      let(:lot_number) { '3' }

      it 'returns lot 3 prospectus link' do
        expect(helper.prospectus_link).to eq lot_3_prospectus_link
      end
    end
  end

  describe '#display_rate' do
    let(:result) { helper.display_rate(position) }
    let(:hourly_partner) { Faker::Number.number(digits: 5) * 100 }
    let(:hourly_trainee) { Faker::Number.number(digits: 3) * 100 }
    let(:hourly_lmp) { 0 }
    let(:supplier) { create(:legal_services_rm6240_supplier) }

    before do
      create(:legal_services_rm6240_full_service_provision_rate, supplier: supplier, rate: hourly_partner, position: '1')
      create(:legal_services_rm6240_full_service_provision_rate, supplier: supplier, rate: hourly_trainee, position: '5')
      create(:legal_services_rm6240_full_service_provision_rate, supplier: supplier, rate: hourly_lmp, position: '7')

      @rate_card = supplier.rates
    end

    context 'when the position is partner (1)' do
      let(:position) { '1' }

      it 'returns the partner rate in punds and pence' do
        expect(result).to eq "£#{(hourly_partner / 100).to_s(:delimited)}.00"
      end
    end

    context 'when the position is Trainee (5)' do
      let(:position) { '5' }

      it 'returns the partner rate in punds and pence' do
        expect(result).to eq "£#{(hourly_trainee / 100).to_s(:delimited)}.00"
      end
    end

    context 'when the position is LMP (Legal project manager) (7)' do
      let(:position) { '7' }

      it 'returns nil' do
        expect(result).to be_nil
      end
    end

    context 'when the position is out of range' do
      let(:position) { '8' }

      it 'returns nil' do
        expect(result).to be_nil
      end
    end
  end
end

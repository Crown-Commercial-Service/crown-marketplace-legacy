require 'rails_helper'

RSpec.describe LegalServices::RM3788::SuppliersHelper, type: :helper do
  let(:lot_number) { rand(1..4).to_s }
  let(:lot) { LegalServices::RM3788::Lot.find_by(number: lot_number) }

  describe '#full_lot_description' do
    it 'returns the full title with lot and description' do
      expect(helper.full_lot_description(lot.number, lot.description)).to eq("Lot #{lot_number} - #{lot.description}")
    end
  end

  describe '.prospectus_link_present?' do
    before do
      params[:lot] = '1'
      @supplier = create(:legal_services_rm3788_supplier, lot_1_prospectus_link: lot_1_prospectus_link)
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
    let(:lot_number) { rand(2..4).to_s }
    let(:link_url) { Faker::Internet.unique.url }

    before do
      params[:lot] = lot_number
      @supplier = create(:legal_services_rm3788_supplier, "lot_#{lot_number}_prospectus_link" => link_text)
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
    let(:lot_2_prospectus_link) { Faker::Internet.unique.url }
    let(:lot_3_prospectus_link) { Faker::Internet.unique.url }
    let(:lot_4_prospectus_link) { Faker::Internet.unique.url }

    before do
      params[:lot] = lot_number
      @supplier = create(:legal_services_rm3788_supplier, lot_2_prospectus_link: lot_2_prospectus_link, lot_3_prospectus_link: lot_3_prospectus_link, lot_4_prospectus_link: lot_4_prospectus_link)
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

    context 'when in lot 4' do
      let(:lot_number) { '4' }

      it 'returns lot 4 prospectus link' do
        expect(helper.prospectus_link).to eq lot_4_prospectus_link
      end
    end
  end

  describe '#display_rate' do
    before { @rate_card = { 'solicitor': { 'hourly': hourly, 'daily': daily, 'monthly': monthly } }.deep_stringify_keys }

    context 'when the rate has no pence' do
      let(:hourly) { Faker::Number.number(digits: 3) * 100 }
      let(:daily) { Faker::Number.number(digits: 4) * 100 }
      let(:monthly) { Faker::Number.number(digits: 5) * 100 }

      it 'displays the rate with pounds and pence' do
        expect(helper.display_rate('solicitor', 'hourly')).to eq "£#{(hourly / 100).to_s(:delimited)}.00"
        expect(helper.display_rate('solicitor', 'daily')).to eq "£#{(daily / 100).to_s(:delimited)}.00"
        expect(helper.display_rate('solicitor', 'monthly')).to eq "£#{(monthly / 100).to_s(:delimited)}.00"
      end
    end

    context 'when the rate has pounds and pence' do
      let(:hourly) { (Faker::Number.decimal(l_digits: 3) * 100).to_i }
      let(:daily) { (Faker::Number.decimal(l_digits: 5) * 100).to_i }
      let(:monthly) { (Faker::Number.decimal(l_digits: 7) * 100).to_i }

      it 'displays the rate with pounds and pence' do
        expect(helper.display_rate('solicitor', 'hourly')).to eq "£#{hourly.to_s[..-3].to_i.to_s(:delimited)}.#{hourly.to_s[-2..]}"
        expect(helper.display_rate('solicitor', 'daily')).to eq "£#{daily.to_s[..-3].to_i.to_s(:delimited)}.#{daily.to_s[-2..]}"
        expect(helper.display_rate('solicitor', 'monthly')).to eq "£#{monthly.to_s[..-3].to_i.to_s(:delimited)}.#{monthly.to_s[-2..]}"
      end
    end
  end
end

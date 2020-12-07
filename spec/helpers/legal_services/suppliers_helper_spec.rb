require 'rails_helper'

RSpec.describe LegalServices::SuppliersHelper, type: :helper do
  let(:lot_number) { rand(1..4).to_s }
  let(:lot) { LegalServices::Lot.find_by(number: lot_number) }

  describe '#full_lot_description' do
    it 'returns the full title with lot and description' do
      expect(helper.full_lot_description(lot.number, lot.description)).to eq("Lot #{lot_number} - #{lot.description}")
    end
  end

  describe '#url_formatter' do
    context 'with a url that is missing the protocol' do
      it 'returns the url with a http protocol' do
        url = 'www.example.com'

        expect(helper.url_formatter(url)).to eq('http://www.example.com')
      end
    end

    context 'with a url that is not missing the protocol' do
      it 'returns the provided url' do
        url = 'https://www.example.com'

        expect(helper.url_formatter(url)).to eq('https://www.example.com')
      end
    end
  end

  describe '#prospectus_link_a_url?' do
    let(:lot_number) { rand(2..4).to_s }
    let(:link_url) { Faker::Internet.unique.url }

    before do
      params[:lot] = lot_number
      @supplier = create(:legal_services_supplier, "lot_#{lot_number}_prospectus_link" => link_text)
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
      @supplier = create(:legal_services_supplier, lot_2_prospectus_link: lot_2_prospectus_link, lot_3_prospectus_link: lot_3_prospectus_link, lot_4_prospectus_link: lot_4_prospectus_link)
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
end

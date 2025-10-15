require 'rails_helper'

RSpec.describe LegalPanelForGovernment::JourneyHelper do
  let(:lot_number) do
    number = rand(1..5).to_s
    letter = number == '4' ? ('a'..'c').to_a.sample : nil

    "#{number}#{letter}"
  end
  let(:lot) { Lot.find_by(framework_id: 'RM6360', number: lot_number) }

  describe '#lot_full_description' do
    it 'returns the full title with lot and description' do
      expect(helper.lot_full_name(lot)).to eq("Lot #{lot_number} - #{lot.name}")
    end
  end

  describe '#lot_legal_specialisms' do
    it 'returns text containing the correct lot number' do
      expect(helper.lot_legal_specialisms(lot)).to eq("Lot #{lot_number} legal specialisms")
    end
  end

  describe '.prospectus_link_present?' do
    let(:lot_number) { '1' }
    let(:supplier_framework) { create(:supplier_framework, contact_detail: create(:supplier_framework_contact_detail, additional_details: { lot_1_prospectus_link: })) }

    before { @lot = lot }

    context 'when the link is nil' do
      let(:lot_1_prospectus_link) { nil }

      it 'returns false' do
        expect(helper.prospectus_link_present?(supplier_framework, lot)).to be false
      end
    end

    context 'when the link is N/A' do
      let(:lot_1_prospectus_link) { 'N/A' }

      it 'returns false' do
        expect(helper.prospectus_link_present?(supplier_framework, lot)).to be false
      end
    end

    context 'when the link is a link' do
      let(:lot_1_prospectus_link) { Faker::Internet.unique.url }

      it 'returns true' do
        expect(helper.prospectus_link_present?(supplier_framework, lot)).to be true
      end
    end
  end

  describe '#prospectus_link_a_url?' do
    let(:link_url) { Faker::Internet.unique.url }
    let(:supplier_framework) { create(:supplier_framework, contact_detail: create(:supplier_framework_contact_detail, additional_details: { "lot_#{lot_number}_prospectus_link" => link_text })) }

    before { @lot = lot }

    context 'when the link is a url' do
      let(:link_text) { link_url }

      it 'returns true' do
        expect(helper.prospectus_link_a_url?(supplier_framework, lot)).to be true
      end
    end

    context 'when the link is text' do
      let(:link_text) { "Please contuct us though the form at #{link_url}" }

      it 'returns false' do
        expect(helper.prospectus_link_a_url?(supplier_framework, lot)).to be false
      end
    end
  end

  describe 'prospectus_link' do
    let(:lot_1_prospectus_link) { Faker::Internet.unique.url }
    let(:lot_2_prospectus_link) { Faker::Internet.unique.url }
    let(:lot_3_prospectus_link) { Faker::Internet.unique.url }
    let(:supplier_framework) { create(:supplier_framework, contact_detail: create(:supplier_framework_contact_detail, additional_details: { lot_1_prospectus_link:, lot_2_prospectus_link:, lot_3_prospectus_link:, })) }

    before { @lot = lot }

    context 'when in lot 1' do
      let(:lot_number) { '1' }

      it 'returns lot 1 prospectus link' do
        expect(helper.prospectus_link(supplier_framework, lot)).to eq lot_1_prospectus_link
      end
    end

    context 'when in lot 2' do
      let(:lot_number) { '2' }

      it 'returns lot 2 prospectus link' do
        expect(helper.prospectus_link(supplier_framework, lot)).to eq lot_2_prospectus_link
      end
    end

    context 'when in lot 3' do
      let(:lot_number) { '3' }

      it 'returns lot 3 prospectus link' do
        expect(helper.prospectus_link(supplier_framework, lot)).to eq lot_3_prospectus_link
      end
    end
  end
end

require 'rails_helper'

RSpec.describe LegalPanelForGovernment::RM6360::SuppliersHelper do
  let(:lot_number) do
    number = rand(1..5).to_s
    letter = number == '4' ? ('a'..'c').to_a.sample : nil

    "#{number}#{letter}"
  end
  let(:lot) { Lot.find_by(framework_id: 'RM6360', number: lot_number) }

  describe '#full_lot_name' do
    it 'returns the full title with lot and description' do
      expect(helper.full_lot_name(lot)).to eq("Lot #{lot_number} - #{lot.name}")
    end
  end

  describe '.prospectus_link_present?' do
    let(:lot_number) { '1' }
    let(:supplier_framework) { create(:supplier_framework, contact_detail: create(:supplier_framework_contact_detail, additional_details: { lot_1_prospectus_link: })) }

    before { @lot = lot }

    context 'when the link is nil' do
      let(:lot_1_prospectus_link) { nil }

      it 'returns false' do
        expect(helper.prospectus_link_present?(supplier_framework)).to be false
      end
    end

    context 'when the link is N/A' do
      let(:lot_1_prospectus_link) { 'N/A' }

      it 'returns false' do
        expect(helper.prospectus_link_present?(supplier_framework)).to be false
      end
    end

    context 'when the link is a link' do
      let(:lot_1_prospectus_link) { Faker::Internet.unique.url }

      it 'returns true' do
        expect(helper.prospectus_link_present?(supplier_framework)).to be true
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
        expect(helper.prospectus_link_a_url?(supplier_framework)).to be true
      end
    end

    context 'when the link is text' do
      let(:link_text) { "Please contuct us though the form at #{link_url}" }

      it 'returns false' do
        expect(helper.prospectus_link_a_url?(supplier_framework)).to be false
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
        expect(helper.prospectus_link(supplier_framework)).to eq lot_1_prospectus_link
      end
    end

    context 'when in lot 2' do
      let(:lot_number) { '2' }

      it 'returns lot 2 prospectus link' do
        expect(helper.prospectus_link(supplier_framework)).to eq lot_2_prospectus_link
      end
    end

    context 'when in lot 3' do
      let(:lot_number) { '3' }

      it 'returns lot 3 prospectus link' do
        expect(helper.prospectus_link(supplier_framework)).to eq lot_3_prospectus_link
      end
    end
  end

  describe '#display_rate' do
    let(:result) { helper.display_rate(position, jurisdiction_id) }
    let(:hourly_1) { Faker::Number.number(digits: 5) * 100 }
    let(:hourly_2) { 0 }
    let(:hourly_3) { Faker::Number.number(digits: 3) * 100 }
    let(:supplier_framework_lot) { create(:supplier_framework_lot) }

    before do
      ae_jurisdiction_id = create(:supplier_framework_lot_jurisdiction, supplier_framework_lot: supplier_framework_lot, jurisdiction_id: 'AE').id
      az_jurisdiction_id = create(:supplier_framework_lot_jurisdiction, supplier_framework_lot: supplier_framework_lot, jurisdiction_id: 'AX').id

      create(:supplier_framework_lot_rate, supplier_framework_lot: supplier_framework_lot, rate: hourly_1, position_id: 1, supplier_framework_lot_jurisdiction_id: ae_jurisdiction_id)
      create(:supplier_framework_lot_rate, supplier_framework_lot: supplier_framework_lot, rate: hourly_1 * 2, position_id: 1, supplier_framework_lot_jurisdiction_id: az_jurisdiction_id)
      create(:supplier_framework_lot_rate, supplier_framework_lot: supplier_framework_lot, rate: hourly_2, position_id: 2, supplier_framework_lot_jurisdiction_id: az_jurisdiction_id)
      create(:supplier_framework_lot_rate, supplier_framework_lot: supplier_framework_lot, rate: hourly_3, position_id: 3, supplier_framework_lot_jurisdiction_id: ae_jurisdiction_id)
      create(:supplier_framework_lot_rate, supplier_framework_lot: supplier_framework_lot, rate: hourly_3 * 4, position_id: 3, supplier_framework_lot_jurisdiction_id: az_jurisdiction_id)

      @rates = supplier_framework_lot.rates.each_with_object({}) do |rate, grouped_rates|
        (grouped_rates[rate.position_id] ||= {})[rate.jurisdiction.jurisdiction_id] = rate
      end
    end

    context 'when the position is 1' do
      let(:position) { 1 }

      context 'and the jurisdiction is AE' do
        let(:jurisdiction_id) { 'AE' }

        it 'returns the rate in punds and pence' do
          expect(result).to eq "£#{(hourly_1 / 100).to_fs(:delimited)}.00"
        end
      end

      context 'and the jurisdiction is AX' do
        let(:jurisdiction_id) { 'AX' }

        it 'returns the rate in punds and pence' do
          expect(result).to eq "£#{(hourly_1 / 50).to_fs(:delimited)}.00"
        end
      end

      context 'and the jurisdiction is DE' do
        let(:jurisdiction_id) { 'DE' }

        it 'returns nil' do
          expect(result).to be_nil
        end
      end
    end

    context 'when the position is 2' do
      let(:position) { 2 }

      context 'and the jurisdiction is AE' do
        let(:jurisdiction_id) { 'AE' }

        it 'returns nil' do
          expect(result).to be_nil
        end
      end

      context 'and the jurisdiction is AX' do
        let(:jurisdiction_id) { 'AX' }

        it 'returns the rate in punds and pence' do
          expect(result).to be_nil
        end
      end

      context 'and the jurisdiction is DE' do
        let(:jurisdiction_id) { 'DE' }

        it 'returns nil' do
          expect(result).to be_nil
        end
      end
    end

    context 'when the position is 3' do
      let(:position) { 3 }

      context 'and the jurisdiction is AE' do
        let(:jurisdiction_id) { 'AE' }

        it 'returns the rate in punds and pence' do
          expect(result).to eq "£#{(hourly_3 / 100).to_fs(:delimited)}.00"
        end
      end

      context 'and the jurisdiction is AX' do
        let(:jurisdiction_id) { 'AX' }

        it 'returns the rate in punds and pence' do
          expect(result).to eq "£#{(hourly_3 / 25).to_fs(:delimited)}.00"
        end
      end

      context 'and the jurisdiction is DE' do
        let(:jurisdiction_id) { 'DE' }

        it 'returns nil' do
          expect(result).to be_nil
        end
      end
    end

    context 'when the position is out of range' do
      let(:position) { 8 }
      let(:jurisdiction_id) { 'AE' }

      it 'returns nil' do
        expect(result).to be_nil
      end
    end
  end
end

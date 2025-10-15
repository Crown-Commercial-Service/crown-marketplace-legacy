require 'rails_helper'

RSpec.describe LegalPanelForGovernment::RM6360::SuppliersHelper do
  let(:lot_number) do
    number = rand(1..5).to_s
    letter = number == '4' ? ('a'..'c').to_a.sample : nil

    "#{number}#{letter}"
  end
  let(:lot) { Lot.find_by(framework_id: 'RM6360', number: lot_number) }

  describe '#positions' do
    [
      [
        '1',
        [
          ['RM6360.1.1', 'partner'],
          ['RM6360.1.2', 'legal_director'],
          ['RM6360.1.3', 'senior'],
          ['RM6360.1.4', 'solicitor'],
          ['RM6360.1.5', 'junior'],
          ['RM6360.1.6', 'trainee'],
          ['RM6360.1.7', 'paralegal'],
        ]
      ],
      [
        '2',
        [
          ['RM6360.2.1', 'partner'],
          ['RM6360.2.2', 'legal_director'],
          ['RM6360.2.3', 'senior'],
          ['RM6360.2.4', 'solicitor'],
          ['RM6360.2.5', 'junior'],
          ['RM6360.2.6', 'trainee'],
          ['RM6360.2.7', 'paralegal'],
        ]
      ],
      [
        '3',
        [
          ['RM6360.3.1', 'partner'],
          ['RM6360.3.2', 'legal_director'],
          ['RM6360.3.3', 'senior'],
          ['RM6360.3.4', 'solicitor'],
          ['RM6360.3.5', 'junior'],
          ['RM6360.3.6', 'trainee'],
          ['RM6360.3.7', 'paralegal'],
        ]
      ],
      [
        '4a',
        [
          ['RM6360.4a.1', 'senior_partner'],
          ['RM6360.4a.2', 'partner'],
          ['RM6360.4a.3', 'legal_director'],
          ['RM6360.4a.4', 'senior'],
          ['RM6360.4a.5', 'solicitor'],
          ['RM6360.4a.6', 'junior'],
          ['RM6360.4a.7', 'trainee'],
          ['RM6360.4a.8', 'paralegal'],
          ['RM6360.4a.9', 'senior_analyst'],
          ['RM6360.4a.10', 'analyst'],
          ['RM6360.4a.11', 'senior_modeller'],
          ['RM6360.4a.12', 'modeller'],
        ]
      ],
      [
        '4b',
        [
          ['RM6360.4b.1', 'senior_partner'],
          ['RM6360.4b.2', 'partner'],
          ['RM6360.4b.3', 'legal_director'],
          ['RM6360.4b.4', 'senior'],
          ['RM6360.4b.5', 'solicitor'],
          ['RM6360.4b.6', 'junior'],
          ['RM6360.4b.7', 'trainee'],
          ['RM6360.4b.8', 'paralegal'],
          ['RM6360.4b.9', 'senior_analyst'],
          ['RM6360.4b.10', 'analyst'],
          ['RM6360.4b.11', 'senior_modeller'],
          ['RM6360.4b.12', 'modeller'],
        ]
      ],
      [
        '4c',
        [
          ['RM6360.4c.1', 'senior_partner'],
          ['RM6360.4c.2', 'partner'],
          ['RM6360.4c.3', 'legal_director'],
          ['RM6360.4c.4', 'senior'],
          ['RM6360.4c.5', 'solicitor'],
          ['RM6360.4c.6', 'junior'],
          ['RM6360.4c.7', 'trainee'],
          ['RM6360.4c.8', 'paralegal'],
          ['RM6360.4c.9', 'senior_analyst'],
          ['RM6360.4c.10', 'analyst'],
          ['RM6360.4c.11', 'senior_modeller'],
          ['RM6360.4c.12', 'modeller'],
        ]
      ],
      [
        '5',
        [
          ['RM6360.5.1', 'partner'],
          ['RM6360.5.2', 'legal_director'],
          ['RM6360.5.3', 'senior'],
          ['RM6360.5.4', 'solicitor'],
          ['RM6360.5.5', 'junior'],
          ['RM6360.5.6', 'trainee'],
          ['RM6360.5.7', 'paralegal'],
        ]
      ]
    ].each do |lot_number, expected_result|
      context "when the lot number is #{lot_number}" do
        it 'returns the expected result' do
          @lot = Lot.find("RM6360.#{lot_number}")

          expect(helper.positions).to eq(expected_result)
        end
      end
    end
  end

  # rubocop:disable RSpec/NestedGroups
  describe '#display_rate' do
    let(:hourly_1_1) { Faker::Number.number(digits: 5) * 100 }
    let(:hourly_1_2) { 0 }
    let(:hourly_1_3) { Faker::Number.number(digits: 3) * 100 }
    let(:hourly_2_1) { Faker::Number.number(digits: 5) * 1000 }
    let(:hourly_2_2) { 0 }
    let(:hourly_2_3) { Faker::Number.number(digits: 3) * 1000 }
    let(:supplier_framework_lot_1) { create(:supplier_framework_lot) }
    let(:supplier_framework_lot_2) { create(:supplier_framework_lot) }

    before do
      [
        [supplier_framework_lot_1, hourly_1_1, hourly_1_2, hourly_1_3],
        [supplier_framework_lot_2, hourly_2_1, hourly_2_2, hourly_2_3],
      ].each do |supplier_framework_lot, hourly_1, hourly_2, hourly_3|
        ae_jurisdiction_id = create(:supplier_framework_lot_jurisdiction, supplier_framework_lot: supplier_framework_lot, jurisdiction_id: 'AE').id
        az_jurisdiction_id = create(:supplier_framework_lot_jurisdiction, supplier_framework_lot: supplier_framework_lot, jurisdiction_id: 'AX').id

        create(:supplier_framework_lot_rate, supplier_framework_lot: supplier_framework_lot, rate: hourly_1, position_id: 'RM6360.1.1', supplier_framework_lot_jurisdiction_id: ae_jurisdiction_id)
        create(:supplier_framework_lot_rate, supplier_framework_lot: supplier_framework_lot, rate: hourly_1 * 2, position_id: 'RM6360.1.1', supplier_framework_lot_jurisdiction_id: az_jurisdiction_id)
        create(:supplier_framework_lot_rate, supplier_framework_lot: supplier_framework_lot, rate: hourly_2, position_id: 'RM6360.1.2', supplier_framework_lot_jurisdiction_id: az_jurisdiction_id)
        create(:supplier_framework_lot_rate, supplier_framework_lot: supplier_framework_lot, rate: hourly_3, position_id: 'RM6360.1.3', supplier_framework_lot_jurisdiction_id: ae_jurisdiction_id)
        create(:supplier_framework_lot_rate, supplier_framework_lot: supplier_framework_lot, rate: hourly_3 * 4, position_id: 'RM6360.1.3', supplier_framework_lot_jurisdiction_id: az_jurisdiction_id)
      end
    end

    context 'when getting rates from the instance variabled' do
      let(:rates) do
        supplier_framework_lot_1.rates.each_with_object({}) do |rate, grouped_rates|
          (grouped_rates[rate.position_id] ||= {})[rate.jurisdiction.jurisdiction_id] = rate
        end
      end

      let(:result) { helper.display_rate(position, jurisdiction_id, rates) }

      context 'when the position is 1' do
        let(:position) { 'RM6360.1.1' }

        context 'and the jurisdiction is AE' do
          let(:jurisdiction_id) { 'AE' }

          it 'returns the rate in punds and pence' do
            expect(result).to eq "£#{(hourly_1_1 / 100).to_fs(:delimited)}.00"
          end
        end

        context 'and the jurisdiction is AX' do
          let(:jurisdiction_id) { 'AX' }

          it 'returns the rate in punds and pence' do
            expect(result).to eq "£#{(hourly_1_1 / 50).to_fs(:delimited)}.00"
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
        let(:position) { 'RM6360.1.2' }

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
        let(:position) { 'RM6360.1.3' }

        context 'and the jurisdiction is AE' do
          let(:jurisdiction_id) { 'AE' }

          it 'returns the rate in punds and pence' do
            expect(result).to eq "£#{(hourly_1_3 / 100).to_fs(:delimited)}.00"
          end
        end

        context 'and the jurisdiction is AX' do
          let(:jurisdiction_id) { 'AX' }

          it 'returns the rate in punds and pence' do
            expect(result).to eq "£#{(hourly_1_3 / 25).to_fs(:delimited)}.00"
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
        let(:position) { 'RM6360.1.8' }
        let(:jurisdiction_id) { 'AE' }

        it 'returns nil' do
          expect(result).to be_nil
        end
      end
    end

    context 'when getting rates from the parameter' do
      let(:rates) do
        supplier_framework_lot_2.rates.each_with_object({}) do |rate, grouped_rates|
          (grouped_rates[rate.position_id] ||= {})[rate.jurisdiction.jurisdiction_id] = rate
        end
      end

      let(:result) { helper.display_rate(position, jurisdiction_id, rates) }

      context 'when the position is 1' do
        let(:position) { 'RM6360.1.1' }

        context 'and the jurisdiction is AE' do
          let(:jurisdiction_id) { 'AE' }

          it 'returns the rate in punds and pence' do
            expect(result).to eq "£#{(hourly_2_1 / 100).to_fs(:delimited)}.00"
          end
        end

        context 'and the jurisdiction is AX' do
          let(:jurisdiction_id) { 'AX' }

          it 'returns the rate in punds and pence' do
            expect(result).to eq "£#{(hourly_2_1 / 50).to_fs(:delimited)}.00"
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
        let(:position) { 'RM6360.1.2' }

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
        let(:position) { 'RM6360.1.3' }

        context 'and the jurisdiction is AE' do
          let(:jurisdiction_id) { 'AE' }

          it 'returns the rate in punds and pence' do
            expect(result).to eq "£#{(hourly_2_3 / 100).to_fs(:delimited)}.00"
          end
        end

        context 'and the jurisdiction is AX' do
          let(:jurisdiction_id) { 'AX' }

          it 'returns the rate in punds and pence' do
            expect(result).to eq "£#{(hourly_2_3 / 25).to_fs(:delimited)}.00"
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
        let(:position) { 'RM6360.1.8' }
        let(:jurisdiction_id) { 'AE' }

        it 'returns nil' do
          expect(result).to be_nil
        end
      end
    end
  end
  # rubocop:enable RSpec/NestedGroups
end

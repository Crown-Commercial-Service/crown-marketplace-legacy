require 'rails_helper'

RSpec.describe LegalServices::RM6240::Rate, type: :model do
  subject(:rate) { build(:legal_services_rm6240_full_service_provision_rate) }

  it { is_expected.to be_valid }

  # rubocop:disable RSpec/NestedGroups
  describe 'validations' do
    context 'when validating the lot number' do
      before { rate.assign_attributes(lot_number: lot_number) }

      context 'and it is blank' do
        let(:lot_number) { nil }

        it 'is not valid' do
          expect(rate).not_to be_valid
        end
      end

      context 'and it is not in the list of lot numbers' do
        let(:lot_number) { '4' }

        it 'is not valid' do
          expect(rate).not_to be_valid
        end
      end
    end

    context 'when validating the jurisdiction' do
      before { rate.assign_attributes(lot_number: lot_number, jurisdiction: jurisdiction) }

      context 'and the lot requires it' do
        let(:lot_number) { '2' }

        context 'and it is blank' do
          let(:jurisdiction) { nil }

          it 'is not valid' do
            expect(rate).not_to be_valid
          end
        end

        context 'and it is not in the list of jurisdictions' do
          let(:jurisdiction) { 'invalid-jurisdiction' }

          it 'is not valid' do
            expect(rate).not_to be_valid
          end
        end
      end

      context 'and lot does not require it' do
        let(:lot_number) { '3' }

        context 'and it is blank' do
          let(:jurisdiction) { nil }

          it 'is valid' do
            expect(rate).to be_valid
          end
        end

        context 'and it is not in the list of jurisdictions' do
          let(:jurisdiction) { 'invalid-jurisdiction' }

          it 'is not valid' do
            expect(rate).not_to be_valid
          end
        end

        context 'and it is in the list of jurisdictions' do
          let(:jurisdiction) { 'a' }

          it 'is not valid' do
            expect(rate).not_to be_valid
          end
        end
      end
    end

    context 'when validating the position' do
      before { rate.assign_attributes(position: position) }

      context 'and it is blank' do
        let(:position) { nil }

        it 'is not valid' do
          expect(rate).not_to be_valid
        end
      end

      context 'and it is not in the list of positions' do
        let(:position) { '8' }

        it 'is not valid' do
          expect(rate).not_to be_valid
        end
      end
    end

    context 'when validating the rate' do
      before { rate.assign_attributes(rate: rate_value) }

      context 'and it is nil' do
        let(:rate_value) { nil }

        it 'is not valid' do
          expect(rate).not_to be_valid
        end
      end

      context 'and it is blank' do
        let(:rate_value) { '' }

        it 'is not valid' do
          expect(rate).not_to be_valid
        end
      end

      context 'and it is a string' do
        let(:rate_value) { 'I am string' }

        it 'is not valid' do
          expect(rate).not_to be_valid
        end
      end

      context 'and it is a float' do
        let(:rate_value) { 12.5 }

        it 'is not valid' do
          expect(rate).not_to be_valid
        end
      end

      context 'and it is an integer' do
        let(:rate_value) { 45 }

        it 'is valid' do
          expect(rate).to be_valid
        end
      end
    end

    context 'when validating the uniqueness' do
      let(:new_rate) do
        build(
          :legal_services_rm6240_rate,
          supplier: supplier,
          lot_number: lot_number,
          jurisdiction: jurisdiction,
          position: position
        )
      end
      let(:supplier) { rate.supplier }
      let(:lot_number) { rate.lot_number }
      let(:jurisdiction) { rate.jurisdiction }
      let(:position) { rate.position }

      before { rate.save }

      context 'when the supplier, lot_number, jurisdiction and position are the same' do
        it 'is not valid' do
          expect(new_rate).not_to be_valid
        end
      end

      context 'when the supplier is different' do
        let(:supplier) { build(:legal_services_rm6240_supplier) }

        it 'is valid' do
          expect(new_rate).to be_valid
        end
      end

      context 'when the lot_number is different' do
        let(:lot_number) { '2' }

        it 'is valid' do
          expect(new_rate).to be_valid
        end
      end

      context 'when the jurisdiction is different' do
        let(:jurisdiction) { 'b' }

        it 'is valid' do
          expect(new_rate).to be_valid
        end
      end

      context 'when the position is different' do
        let(:position) { '2' }

        it 'is valid' do
          expect(new_rate).to be_valid
        end
      end
    end
  end
  # rubocop:enable RSpec/NestedGroups

  describe 'value' do
    before { rate.assign_attributes(rate: rate_value) }

    context 'and the rate value is 3550' do
      let(:rate_value) { 3550 }

      it 'returns 35.5' do
        expect(rate.value).to eq 35.5
      end
    end

    context 'and the rate value is 1200' do
      let(:rate_value) { 1200 }

      it 'returns 12.0' do
        expect(rate.value).to eq 12.0
      end
    end
  end
end

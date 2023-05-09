require 'rails_helper'

RSpec.describe Dateable do
  include described_class

  # rubocop:disable RSpec/NestedGroups
  describe '.difference_in_months when near the end of a the month' do
    let(:result) { difference_in_months(start_date, end_date) }

    context 'when the start date is the last day of the month' do
      context 'and the end date is the last day of the month' do
        context 'and start date day is after the end date day' do
          let(:start_date) { Date.new(2023, 4, 30) }
          let(:end_date) { Date.new(2024, 2, 29) }

          it 'returns 10' do
            expect(result).to eq(10)
          end
        end

        context 'and start date day is the same as the end date day' do
          let(:start_date) { Date.new(2023, 4, 30) }
          let(:end_date) { Date.new(2023, 6, 30) }

          it 'returns 2' do
            expect(result).to eq(2)
          end
        end

        context 'and start date day is before the end date day' do
          let(:start_date) { Date.new(2023, 4, 30) }
          let(:end_date) { Date.new(2023, 7, 31) }

          it 'returns 3' do
            expect(result).to eq(3)
          end
        end
      end

      context 'and the end date is not the last day of the month' do
        context 'and start date day is after the end date day' do
          let(:start_date) { Date.new(2023, 4, 30) }
          let(:end_date) { Date.new(2023, 6, 29) }

          it 'returns 1.5' do
            expect(result).to eq(1.5)
          end
        end

        context 'and start date day is the same as the end date day' do
          let(:start_date) { Date.new(2023, 4, 30) }
          let(:end_date) { Date.new(2023, 7, 30) }

          it 'returns 3' do
            expect(result).to eq(3)
          end
        end

        context 'and start date day is before the end date day' do
          let(:start_date) { Date.new(2023, 2, 28) }
          let(:end_date) { Date.new(2023, 3, 29) }

          it 'returns 1' do
            expect(result).to eq(1)
          end
        end
      end
    end

    context 'when the start date is the not last day of the month' do
      context 'and the end date is the last day of the month' do
        context 'and start date day is after the end date day' do
          let(:start_date) { Date.new(2023, 5, 30) }
          let(:end_date) { Date.new(2024, 2, 29) }

          it 'returns 9' do
            expect(result).to eq(9)
          end
        end

        context 'and start date day is the same as the end date day' do
          let(:start_date) { Date.new(2023, 4, 29) }
          let(:end_date) { Date.new(2024, 2, 29) }

          it 'returns 10' do
            expect(result).to eq(10)
          end
        end

        context 'and start date day is before the end date day' do
          let(:start_date) { Date.new(2023, 3, 27) }
          let(:end_date) { Date.new(2024, 2, 29) }

          it 'returns 11' do
            expect(result).to eq(11)
          end
        end
      end

      context 'and the end date is not the last day of the month' do
        context 'and start date day is after the end date day' do
          let(:start_date) { Date.new(2023, 5, 25) }
          let(:end_date) { Date.new(2023, 7, 24) }

          it 'returns 1.5' do
            expect(result).to eq(1.5)
          end
        end

        context 'and start date day is the same as the end date day' do
          let(:start_date) { Date.new(2023, 5, 25) }
          let(:end_date) { Date.new(2023, 7, 25) }

          it 'returns 2' do
            expect(result).to eq(2)
          end
        end

        context 'and start date day is before the end date day' do
          let(:start_date) { Date.new(2023, 5, 25) }
          let(:end_date) { Date.new(2023, 7, 26) }

          it 'returns 2' do
            expect(result).to eq(2)
          end
        end
      end
    end
  end

  describe '.difference_in_months with days throughout the month' do
    let(:result) { difference_in_months(start_date, end_date) }

    let(:start_date) { Date.new(2023, 3, start_date_day) }

    context 'when the start date day is the first day of the month' do
      let(:start_date_day) { 1 }

      context 'when the end date day is same as the start date day' do
        let(:end_date) { Date.new(2023, 6, 1) }

        it 'returns 3' do
          expect(result).to eq(3)
        end
      end

      context 'when the end date day is one day after the start date day' do
        let(:end_date) { Date.new(2023, 6, 2) }

        it 'returns 3' do
          expect(result).to eq(3)
        end
      end

      context 'when the end date day is several days after the start date day' do
        let(:end_date) { Date.new(2023, 6, 10) }

        it 'returns 3' do
          expect(result).to eq(3)
        end
      end

      context 'when the end date day is just before the midpoint of days after the start date day' do
        let(:end_date) { Date.new(2023, 6, 15) }

        it 'returns 3' do
          expect(result).to eq(3)
        end
      end

      context 'when the end date day is on the midpoint of days after the start date day' do
        let(:end_date) { Date.new(2023, 6, 16) }

        it 'returns 3.5' do
          expect(result).to eq(3.5)
        end
      end

      context 'when the end date day is just after the midpoint of days after the start date day' do
        let(:end_date) { Date.new(2023, 6, 17) }

        it 'returns 3.5' do
          expect(result).to eq(3.5)
        end
      end

      context 'when the end date day is several days before one month after the start date day' do
        let(:end_date) { Date.new(2023, 6, 24) }

        it 'returns 3.5' do
          expect(result).to eq(3.5)
        end
      end

      context 'when the end date day is the day before one month after the start date day' do
        let(:end_date) { Date.new(2023, 6, 30) }

        it 'returns 3.5' do
          expect(result).to eq(3.5)
        end
      end

      context 'when the end date day is one month after the start date day' do
        let(:end_date) { Date.new(2023, 7, 1) }

        it 'returns 4' do
          expect(result).to eq(4)
        end
      end
    end

    context 'when the start date day is the second day of the month' do
      let(:start_date_day) { 2 }

      context 'when the end date day is same as the start date day' do
        let(:end_date) { Date.new(2023, 6, 2) }

        it 'returns 3' do
          expect(result).to eq(3)
        end
      end

      context 'when the end date day is one day after the start date day' do
        let(:end_date) { Date.new(2023, 6, 3) }

        it 'returns 3' do
          expect(result).to eq(3)
        end
      end

      context 'when the end date day is several days after the start date day' do
        let(:end_date) { Date.new(2023, 6, 11) }

        it 'returns 3' do
          expect(result).to eq(3)
        end
      end

      context 'when the end date day is just before the midpoint of days after the start date day' do
        let(:end_date) { Date.new(2023, 6, 16) }

        it 'returns 3' do
          expect(result).to eq(3)
        end
      end

      context 'when the end date day is on the midpoint of days after the start date day' do
        let(:end_date) { Date.new(2023, 6, 17) }

        it 'returns 3.5' do
          expect(result).to eq(3.5)
        end
      end

      context 'when the end date day is just after the midpoint of days after the start date day' do
        let(:end_date) { Date.new(2023, 6, 18) }

        it 'returns 3.5' do
          expect(result).to eq(3.5)
        end
      end

      context 'when the end date day is several days before one month after the start date day' do
        let(:end_date) { Date.new(2023, 6, 25) }

        it 'returns 3.5' do
          expect(result).to eq(3.5)
        end
      end

      context 'when the end date day is the day before one month after the start date day' do
        let(:end_date) { Date.new(2023, 7, 1) }

        it 'returns 3.5' do
          expect(result).to eq(3.5)
        end
      end

      context 'when the end date day is one month after the start date day' do
        let(:end_date) { Date.new(2023, 7, 2) }

        it 'returns 4' do
          expect(result).to eq(4)
        end
      end
    end

    context 'when the start date day is the first half of the month' do
      let(:start_date_day) { 10 }

      context 'when the end date day is same as the start date day' do
        let(:end_date) { Date.new(2023, 6, 10) }

        it 'returns 3' do
          expect(result).to eq(3)
        end
      end

      context 'when the end date day is one day after the start date day' do
        let(:end_date) { Date.new(2023, 6, 11) }

        it 'returns 3' do
          expect(result).to eq(3)
        end
      end

      context 'when the end date day is several days after the start date day' do
        let(:end_date) { Date.new(2023, 6, 19) }

        it 'returns 3' do
          expect(result).to eq(3)
        end
      end

      context 'when the end date day is just before the midpoint of days after the start date day' do
        let(:end_date) { Date.new(2023, 6, 24) }

        it 'returns 3' do
          expect(result).to eq(3)
        end
      end

      context 'when the end date day is on the midpoint of days after the start date day' do
        let(:end_date) { Date.new(2023, 6, 25) }

        it 'returns 3.5' do
          expect(result).to eq(3.5)
        end
      end

      context 'when the end date day is just after the midpoint of days after the start date day' do
        let(:end_date) { Date.new(2023, 6, 26) }

        it 'returns 3.5' do
          expect(result).to eq(3.5)
        end
      end

      context 'when the end date day is several days before one month after the start date day' do
        let(:end_date) { Date.new(2023, 7, 2) }

        it 'returns 3.5' do
          expect(result).to eq(3.5)
        end
      end

      context 'when the end date day is the day before one month after the start date day' do
        let(:end_date) { Date.new(2023, 7, 9) }

        it 'returns 3.5' do
          expect(result).to eq(3.5)
        end
      end

      context 'when the end date day is one month after the start date day' do
        let(:end_date) { Date.new(2023, 7, 10) }

        it 'returns 4' do
          expect(result).to eq(4)
        end
      end
    end

    context 'when the start date day is just before the middle of the month' do
      let(:start_date_day) { 15 }

      context 'when the end date day is same as the start date day' do
        let(:end_date) { Date.new(2023, 6, 15) }

        it 'returns 3' do
          expect(result).to eq(3)
        end
      end

      context 'when the end date day is one day after the start date day' do
        let(:end_date) { Date.new(2023, 6, 16) }

        it 'returns 3' do
          expect(result).to eq(3)
        end
      end

      context 'when the end date day is several days after the start date day' do
        let(:end_date) { Date.new(2023, 6, 24) }

        it 'returns 3' do
          expect(result).to eq(3)
        end
      end

      context 'when the end date day is just before the midpoint of days after the start date day' do
        let(:end_date) { Date.new(2023, 6, 29) }

        it 'returns 3' do
          expect(result).to eq(3)
        end
      end

      context 'when the end date day is on the midpoint of days after the start date day' do
        let(:end_date) { Date.new(2023, 6, 30) }

        it 'returns 3.5' do
          expect(result).to eq(3.5)
        end
      end

      context 'when the end date day is just after the midpoint of days after the start date day' do
        let(:end_date) { Date.new(2023, 7, 1) }

        it 'returns 3.5' do
          expect(result).to eq(3.5)
        end
      end

      context 'when the end date day is several days before one month after the start date day' do
        let(:end_date) { Date.new(2023, 7, 8) }

        it 'returns 3.5' do
          expect(result).to eq(3.5)
        end
      end

      context 'when the end date day is the day before one month after the start date day' do
        let(:end_date) { Date.new(2023, 7, 14) }

        it 'returns 3.5' do
          expect(result).to eq(3.5)
        end
      end

      context 'when the end date day is one month after the start date day' do
        let(:end_date) { Date.new(2023, 7, 15) }

        it 'returns 4' do
          expect(result).to eq(4)
        end
      end
    end

    context 'when the start date day is on the middle of the month' do
      let(:start_date_day) { 16 }

      context 'when the end date day is same as the start date day' do
        let(:end_date) { Date.new(2023, 6, 16) }

        it 'returns 3' do
          expect(result).to eq(3)
        end
      end

      context 'when the end date day is one day after the start date day' do
        let(:end_date) { Date.new(2023, 6, 17) }

        it 'returns 3' do
          expect(result).to eq(3)
        end
      end

      context 'when the end date day is several days after the start date day' do
        let(:end_date) { Date.new(2023, 6, 25) }

        it 'returns 3' do
          expect(result).to eq(3)
        end
      end

      context 'when the end date day is just before the midpoint of days after the start date day' do
        let(:end_date) { Date.new(2023, 7, 1) }

        it 'returns 3' do
          expect(result).to eq(3)
        end
      end

      context 'when the end date day is on the midpoint of days after the start date day' do
        let(:end_date) { Date.new(2023, 7, 2) }

        it 'returns 3.5' do
          expect(result).to eq(3.5)
        end
      end

      context 'when the end date day is just after the midpoint of days after the start date day' do
        let(:end_date) { Date.new(2023, 7, 3) }

        it 'returns 3.5' do
          expect(result).to eq(3.5)
        end
      end

      context 'when the end date day is several days before the end of the start date day' do
        let(:end_date) { Date.new(2023, 7, 8) }

        it 'returns 3.5' do
          expect(result).to eq(3.5)
        end
      end

      context 'when the end date day is the day before one month after the start date day' do
        let(:end_date) { Date.new(2023, 7, 15) }

        it 'returns 3.5' do
          expect(result).to eq(3.5)
        end
      end

      context 'when the end date day is one month after the start date day' do
        let(:end_date) { Date.new(2023, 7, 16) }

        it 'returns 4' do
          expect(result).to eq(4)
        end
      end
    end

    context 'when the start date day is just after the middle of the month' do
      let(:start_date_day) { 17 }

      context 'when the end date day is same as the start date day' do
        let(:end_date) { Date.new(2023, 6, 17) }

        it 'returns 3' do
          expect(result).to eq(3)
        end
      end

      context 'when the end date day is one day after the start date day' do
        let(:end_date) { Date.new(2023, 6, 18) }

        it 'returns 3' do
          expect(result).to eq(3)
        end
      end

      context 'when the end date day is several days after the start date day' do
        let(:end_date) { Date.new(2023, 6, 26) }

        it 'returns 3' do
          expect(result).to eq(3)
        end
      end

      context 'when the end date day is just before the midpoint of days after the start date day' do
        let(:end_date) { Date.new(2023, 7, 2) }

        it 'returns 3' do
          expect(result).to eq(3)
        end
      end

      context 'when the end date day is on the midpoint of days after the start date day' do
        let(:end_date) { Date.new(2023, 7, 3) }

        it 'returns 3.5' do
          expect(result).to eq(3.5)
        end
      end

      context 'when the end date day is just after the midpoint of days after the start date day' do
        let(:end_date) { Date.new(2023, 7, 4) }

        it 'returns 3.5' do
          expect(result).to eq(3.5)
        end
      end

      context 'when the end date day is several days before the end of the start date day' do
        let(:end_date) { Date.new(2023, 7, 9) }

        it 'returns 3.5' do
          expect(result).to eq(3.5)
        end
      end

      context 'when the end date day is the day before one month after the start date day' do
        let(:end_date) { Date.new(2023, 7, 16) }

        it 'returns 3.5' do
          expect(result).to eq(3.5)
        end
      end

      context 'when the end date day is one month after the start date day' do
        let(:end_date) { Date.new(2023, 7, 17) }

        it 'returns 4' do
          expect(result).to eq(4)
        end
      end
    end

    context 'when the start date day is in the second half of the month' do
      let(:start_date_day) { 24 }

      context 'when the end date day is same as the start date day' do
        let(:end_date) { Date.new(2023, 6, 24) }

        it 'returns 3' do
          expect(result).to eq(3)
        end
      end

      context 'when the end date day is one day after the start date day' do
        let(:end_date) { Date.new(2023, 6, 25) }

        it 'returns 3' do
          expect(result).to eq(3)
        end
      end

      context 'when the end date day is several days after the start date day' do
        let(:end_date) { Date.new(2023, 7, 3) }

        it 'returns 3' do
          expect(result).to eq(3)
        end
      end

      context 'when the end date day is just before the midpoint of days after the start date day' do
        let(:end_date) { Date.new(2023, 7, 9) }

        it 'returns 3' do
          expect(result).to eq(3)
        end
      end

      context 'when the end date day is on the midpoint of days after the start date day' do
        let(:end_date) { Date.new(2023, 7, 10) }

        it 'returns 3.5' do
          expect(result).to eq(3.5)
        end
      end

      context 'when the end date day is just after the midpoint of days after the start date day' do
        let(:end_date) { Date.new(2023, 7, 11) }

        it 'returns 3.5' do
          expect(result).to eq(3.5)
        end
      end

      context 'when the end date day is several days before the end of the start date day' do
        let(:end_date) { Date.new(2023, 7, 16) }

        it 'returns 3.5' do
          expect(result).to eq(3.5)
        end
      end

      context 'when the end date day is the day before one month after the start date day' do
        let(:end_date) { Date.new(2023, 7, 23) }

        it 'returns 3.5' do
          expect(result).to eq(3.5)
        end
      end

      context 'when the end date day is one month after the start date day' do
        let(:end_date) { Date.new(2023, 7, 24) }

        it 'returns 4' do
          expect(result).to eq(4)
        end
      end
    end

    context 'when the start date day is just before the penultimate day of the month' do
      let(:start_date_day) { 30 }

      context 'when the end date day is same as the start date day' do
        let(:end_date) { Date.new(2023, 6, 30) }

        it 'returns 3' do
          expect(result).to eq(3)
        end
      end

      context 'when the end date day is one day after the start date day' do
        let(:end_date) { Date.new(2023, 7, 1) }

        it 'returns 3' do
          expect(result).to eq(3)
        end
      end

      context 'when the end date day is several days after the start date day' do
        let(:end_date) { Date.new(2023, 7, 9) }

        it 'returns 3' do
          expect(result).to eq(3)
        end
      end

      context 'when the end date day is just before the midpoint of days after the start date day' do
        let(:end_date) { Date.new(2023, 7, 15) }

        it 'returns 3' do
          expect(result).to eq(3)
        end
      end

      context 'when the end date day is on the midpoint of days after the start date day' do
        let(:end_date) { Date.new(2023, 7, 16) }

        it 'returns 3.5' do
          expect(result).to eq(3.5)
        end
      end

      context 'when the end date day is just after the midpoint of days after the start date day' do
        let(:end_date) { Date.new(2023, 7, 17) }

        it 'returns 3.5' do
          expect(result).to eq(3.5)
        end
      end

      context 'when the end date day is several days before the end of the start date day' do
        let(:end_date) { Date.new(2023, 7, 22) }

        it 'returns 3.5' do
          expect(result).to eq(3.5)
        end
      end

      context 'when the end date day is the day before one month after the start date day' do
        let(:end_date) { Date.new(2023, 7, 29) }

        it 'returns 3.5' do
          expect(result).to eq(3.5)
        end
      end

      context 'when the end date day is one month after the start date day' do
        let(:end_date) { Date.new(2023, 7, 30) }

        it 'returns 4' do
          expect(result).to eq(4)
        end
      end
    end

    context 'when the start date day is the last day of the month' do
      let(:start_date_day) { 31 }

      context 'when the end date day is same as the start date day' do
        let(:end_date) { Date.new(2023, 6, 30) }

        it 'returns 3' do
          expect(result).to eq(3)
        end
      end

      context 'when the end date day is one day after the start date day' do
        let(:end_date) { Date.new(2023, 7, 1) }

        it 'returns 3' do
          expect(result).to eq(3)
        end
      end

      context 'when the end date day is several days after the start date day' do
        let(:end_date) { Date.new(2023, 7, 9) }

        it 'returns 3' do
          expect(result).to eq(3)
        end
      end

      context 'when the end date day is just before the midpoint of days after the start date day' do
        let(:end_date) { Date.new(2023, 7, 15) }

        it 'returns 3' do
          expect(result).to eq(3)
        end
      end

      context 'when the end date day is on the midpoint of days after the start date day' do
        let(:end_date) { Date.new(2023, 7, 16) }

        it 'returns 3.5' do
          expect(result).to eq(3.5)
        end
      end

      context 'when the end date day is just after the midpoint of days after the start date day' do
        let(:end_date) { Date.new(2023, 7, 17) }

        it 'returns 3.5' do
          expect(result).to eq(3.5)
        end
      end

      context 'when the end date day is several days before the end of the start date day' do
        let(:end_date) { Date.new(2023, 7, 22) }

        it 'returns 3.5' do
          expect(result).to eq(3.5)
        end
      end

      context 'when the end date day is the day before one month after the start date day' do
        let(:end_date) { Date.new(2023, 7, 30) }

        it 'returns 3.5' do
          expect(result).to eq(3.5)
        end
      end

      context 'when the end date day is one month after the start date day' do
        let(:end_date) { Date.new(2023, 7, 31) }

        it 'returns 4' do
          expect(result).to eq(4)
        end
      end
    end
  end

  describe '.difference_in_months when the start and end date are swapped' do
    let(:result_start_end) { difference_in_months(start_date, end_date) }
    let(:result_end_start) { difference_in_months(end_date, start_date) }

    context 'when the start date is 2023/04/30 and the end date is 2024/02/29' do
      let(:start_date) { Date.new(2023, 4, 30) }
      let(:end_date) { Date.new(2024, 2, 29) }

      it 'returns the same result irrespective of the date order' do
        expect(result_end_start).to eq(result_start_end)
      end
    end

    context 'when the start date is 2023/04/30 and the end date is 2023/06/29' do
      let(:start_date) { Date.new(2023, 4, 30) }
      let(:end_date) { Date.new(2023, 6, 29) }

      it 'returns the same result irrespective of the date order' do
        expect(result_end_start).to eq(result_start_end)
      end
    end

    context 'when the start date is 2023/05/30 and the end date is 2024/02/29' do
      let(:start_date) { Date.new(2023, 5, 30) }
      let(:end_date) { Date.new(2024, 2, 29) }

      it 'returns the same result irrespective of the date order' do
        expect(result_end_start).to eq(result_start_end)
      end
    end
  end

  # TODO: number_of_full_months

  describe '.number_of_full_months' do
    let(:result) { number_of_full_months(start_date, end_date) }

    let(:start_date) { Date.new(2023, 3, start_date_day) }

    context 'when the start date day is the first day of the month' do
      let(:start_date_day) { 1 }

      context 'when the end date is one day before the full month' do
        let(:end_date) { Date.new(2023, 10, 31) }

        it 'returns 7' do
          expect(result).to eq 7
        end
      end

      context 'when the end date is one month later' do
        let(:end_date) { Date.new(2023, 11, 1) }

        it 'returns 8' do
          expect(result).to eq 8
        end
      end
    end

    context 'when the start date day is just before the middle of the month' do
      let(:start_date_day) { 15 }

      context 'when the end date is one day before the full month' do
        let(:end_date) { Date.new(2023, 11, 14) }

        it 'returns 7' do
          expect(result).to eq 7
        end
      end

      context 'when the end date is one month later' do
        let(:end_date) { Date.new(2023, 11, 15) }

        it 'returns 8' do
          expect(result).to eq 8
        end
      end
    end

    context 'when the start date day is on the middle of the month' do
      let(:start_date_day) { 16 }

      context 'when the end date is one day before the full month' do
        let(:end_date) { Date.new(2023, 11, 15) }

        it 'returns 7' do
          expect(result).to eq 7
        end
      end

      context 'when the end date is one month later' do
        let(:end_date) { Date.new(2023, 11, 16) }

        it 'returns 8' do
          expect(result).to eq 8
        end
      end
    end

    context 'when the start date day is just after the middle of the month' do
      let(:start_date_day) { 17 }

      context 'when the end date is one day before the full month' do
        let(:end_date) { Date.new(2023, 11, 16) }

        it 'returns 7' do
          expect(result).to eq 7
        end
      end

      context 'when the end date is one month later' do
        let(:end_date) { Date.new(2023, 11, 17) }

        it 'returns 8' do
          expect(result).to eq 8
        end
      end
    end

    context 'when the start date day is the last day of the month' do
      let(:start_date_day) { 31 }

      context 'when the end date is one day before the full month' do
        context 'when the end date is one day before the full month' do
          let(:end_date) { Date.new(2023, 11, 29) }

          it 'returns 7' do
            expect(result).to eq 7
          end
        end

        context 'when the end date is one month later' do
          let(:end_date) { Date.new(2023, 11, 30) }

          it 'returns 8' do
            expect(result).to eq 8
          end
        end
      end
    end
  end

  describe '.half_month' do
    let(:result) { half_month(start_date, end_date, no_of_months) }

    let(:start_date) { Date.new(2023, 3, start_date_day) }
    let(:no_of_months) { 3 }

    context 'when the start date day is the first day of the month' do
      let(:start_date_day) { 1 }

      context 'when the end date day is same as the start date day' do
        let(:end_date) { Date.new(2023, 6, 1) }

        it 'returns 0' do
          expect(result).to eq(0)
        end
      end

      context 'when the end date day is one day after the start date day' do
        let(:end_date) { Date.new(2023, 6, 2) }

        it 'returns 0' do
          expect(result).to eq(0)
        end
      end

      context 'when the end date day is several days after the start date day' do
        let(:end_date) { Date.new(2023, 6, 10) }

        it 'returns 0' do
          expect(result).to eq(0)
        end
      end

      context 'when the end date day is just before the midpoint of days after the start date day' do
        let(:end_date) { Date.new(2023, 6, 15) }

        it 'returns 0' do
          expect(result).to eq(0)
        end
      end

      context 'when the end date day is on the midpoint of days after the start date day' do
        let(:end_date) { Date.new(2023, 6, 16) }

        it 'returns 0.5' do
          expect(result).to eq(0.5)
        end
      end

      context 'when the end date day is just after the midpoint of days after the start date day' do
        let(:end_date) { Date.new(2023, 6, 17) }

        it 'returns 0.5' do
          expect(result).to eq(0.5)
        end
      end

      context 'when the end date day is several days before one month after the start date day' do
        let(:end_date) { Date.new(2023, 6, 24) }

        it 'returns 0.5' do
          expect(result).to eq(0.5)
        end
      end

      context 'when the end date day is the day before one month after the start date day' do
        let(:end_date) { Date.new(2023, 6, 30) }

        it 'returns 0.5' do
          expect(result).to eq(0.5)
        end
      end

      context 'when the end date day is one month after the start date day' do
        let(:end_date) { Date.new(2023, 7, 1) }
        let(:no_of_months) { 4 }

        it 'returns 0' do
          expect(result).to eq(0)
        end
      end
    end

    context 'when the start date day is the second day of the month' do
      let(:start_date_day) { 2 }

      context 'when the end date day is same as the start date day' do
        let(:end_date) { Date.new(2023, 6, 2) }

        it 'returns 0' do
          expect(result).to eq(0)
        end
      end

      context 'when the end date day is one day after the start date day' do
        let(:end_date) { Date.new(2023, 6, 3) }

        it 'returns 0' do
          expect(result).to eq(0)
        end
      end

      context 'when the end date day is several days after the start date day' do
        let(:end_date) { Date.new(2023, 6, 11) }

        it 'returns 0' do
          expect(result).to eq(0)
        end
      end

      context 'when the end date day is just before the midpoint of days after the start date day' do
        let(:end_date) { Date.new(2023, 6, 16) }

        it 'returns 0' do
          expect(result).to eq(0)
        end
      end

      context 'when the end date day is on the midpoint of days after the start date day' do
        let(:end_date) { Date.new(2023, 6, 17) }

        it 'returns 0.5' do
          expect(result).to eq(0.5)
        end
      end

      context 'when the end date day is just after the midpoint of days after the start date day' do
        let(:end_date) { Date.new(2023, 6, 18) }

        it 'returns 0.5' do
          expect(result).to eq(0.5)
        end
      end

      context 'when the end date day is several days before one month after the start date day' do
        let(:end_date) { Date.new(2023, 6, 25) }

        it 'returns 0.5' do
          expect(result).to eq(0.5)
        end
      end

      context 'when the end date day is the day before one month after the start date day' do
        let(:end_date) { Date.new(2023, 7, 1) }

        it 'returns 0.5' do
          expect(result).to eq(0.5)
        end
      end

      context 'when the end date day is one month after the start date day' do
        let(:end_date) { Date.new(2023, 7, 2) }
        let(:no_of_months) { 4 }

        it 'returns 0' do
          expect(result).to eq(0)
        end
      end
    end

    context 'when the start date day is the first half of the month' do
      let(:start_date_day) { 10 }

      context 'when the end date day is same as the start date day' do
        let(:end_date) { Date.new(2023, 6, 10) }

        it 'returns 0' do
          expect(result).to eq(0)
        end
      end

      context 'when the end date day is one day after the start date day' do
        let(:end_date) { Date.new(2023, 6, 11) }

        it 'returns 0' do
          expect(result).to eq(0)
        end
      end

      context 'when the end date day is several days after the start date day' do
        let(:end_date) { Date.new(2023, 6, 19) }

        it 'returns 0' do
          expect(result).to eq(0)
        end
      end

      context 'when the end date day is just before the midpoint of days after the start date day' do
        let(:end_date) { Date.new(2023, 6, 24) }

        it 'returns 0' do
          expect(result).to eq(0)
        end
      end

      context 'when the end date day is on the midpoint of days after the start date day' do
        let(:end_date) { Date.new(2023, 6, 25) }

        it 'returns 0.5' do
          expect(result).to eq(0.5)
        end
      end

      context 'when the end date day is just after the midpoint of days after the start date day' do
        let(:end_date) { Date.new(2023, 6, 26) }

        it 'returns 0.5' do
          expect(result).to eq(0.5)
        end
      end

      context 'when the end date day is several days before one month after the start date day' do
        let(:end_date) { Date.new(2023, 7, 2) }

        it 'returns 0.5' do
          expect(result).to eq(0.5)
        end
      end

      context 'when the end date day is the day before one month after the start date day' do
        let(:end_date) { Date.new(2023, 7, 9) }

        it 'returns 0.5' do
          expect(result).to eq(0.5)
        end
      end

      context 'when the end date day is one month after the start date day' do
        let(:end_date) { Date.new(2023, 7, 10) }
        let(:no_of_months) { 4 }

        it 'returns 0' do
          expect(result).to eq(0)
        end
      end
    end

    context 'when the start date day is just before the middle of the month' do
      let(:start_date_day) { 15 }

      context 'when the end date day is same as the start date day' do
        let(:end_date) { Date.new(2023, 6, 15) }

        it 'returns 0' do
          expect(result).to eq(0)
        end
      end

      context 'when the end date day is one day after the start date day' do
        let(:end_date) { Date.new(2023, 6, 16) }

        it 'returns 0' do
          expect(result).to eq(0)
        end
      end

      context 'when the end date day is several days after the start date day' do
        let(:end_date) { Date.new(2023, 6, 24) }

        it 'returns 0' do
          expect(result).to eq(0)
        end
      end

      context 'when the end date day is just before the midpoint of days after the start date day' do
        let(:end_date) { Date.new(2023, 6, 29) }

        it 'returns 0' do
          expect(result).to eq(0)
        end
      end

      context 'when the end date day is on the midpoint of days after the start date day' do
        let(:end_date) { Date.new(2023, 6, 30) }

        it 'returns 0.5' do
          expect(result).to eq(0.5)
        end
      end

      context 'when the end date day is just after the midpoint of days after the start date day' do
        let(:end_date) { Date.new(2023, 7, 1) }

        it 'returns 0.5' do
          expect(result).to eq(0.5)
        end
      end

      context 'when the end date day is several days before one month after the start date day' do
        let(:end_date) { Date.new(2023, 7, 8) }

        it 'returns 0.5' do
          expect(result).to eq(0.5)
        end
      end

      context 'when the end date day is the day before one month after the start date day' do
        let(:end_date) { Date.new(2023, 7, 14) }

        it 'returns 0.5' do
          expect(result).to eq(0.5)
        end
      end

      context 'when the end date day is one month after the start date day' do
        let(:end_date) { Date.new(2023, 7, 15) }
        let(:no_of_months) { 4 }

        it 'returns 0' do
          expect(result).to eq(0)
        end
      end
    end

    context 'when the start date day is on the middle of the month' do
      let(:start_date_day) { 16 }

      context 'when the end date day is same as the start date day' do
        let(:end_date) { Date.new(2023, 6, 16) }

        it 'returns 0' do
          expect(result).to eq(0)
        end
      end

      context 'when the end date day is one day after the start date day' do
        let(:end_date) { Date.new(2023, 6, 17) }

        it 'returns 0' do
          expect(result).to eq(0)
        end
      end

      context 'when the end date day is several days after the start date day' do
        let(:end_date) { Date.new(2023, 6, 25) }

        it 'returns 0' do
          expect(result).to eq(0)
        end
      end

      context 'when the end date day is just before the midpoint of days after the start date day' do
        let(:end_date) { Date.new(2023, 7, 1) }

        it 'returns 0' do
          expect(result).to eq(0)
        end
      end

      context 'when the end date day is on the midpoint of days after the start date day' do
        let(:end_date) { Date.new(2023, 7, 2) }

        it 'returns 0.5' do
          expect(result).to eq(0.5)
        end
      end

      context 'when the end date day is just after the midpoint of days after the start date day' do
        let(:end_date) { Date.new(2023, 7, 3) }

        it 'returns 0.5' do
          expect(result).to eq(0.5)
        end
      end

      context 'when the end date day is several days before the end of the start date day' do
        let(:end_date) { Date.new(2023, 7, 8) }

        it 'returns 0.5' do
          expect(result).to eq(0.5)
        end
      end

      context 'when the end date day is the day before one month after the start date day' do
        let(:end_date) { Date.new(2023, 7, 15) }

        it 'returns 0.5' do
          expect(result).to eq(0.5)
        end
      end

      context 'when the end date day is one month after the start date day' do
        let(:end_date) { Date.new(2023, 7, 16) }
        let(:no_of_months) { 4 }

        it 'returns 0' do
          expect(result).to eq(0)
        end
      end
    end

    context 'when the start date day is just after the middle of the month' do
      let(:start_date_day) { 17 }

      context 'when the end date day is same as the start date day' do
        let(:end_date) { Date.new(2023, 6, 17) }

        it 'returns 0' do
          expect(result).to eq(0)
        end
      end

      context 'when the end date day is one day after the start date day' do
        let(:end_date) { Date.new(2023, 6, 18) }

        it 'returns 0' do
          expect(result).to eq(0)
        end
      end

      context 'when the end date day is several days after the start date day' do
        let(:end_date) { Date.new(2023, 6, 26) }

        it 'returns 0' do
          expect(result).to eq(0)
        end
      end

      context 'when the end date day is just before the midpoint of days after the start date day' do
        let(:end_date) { Date.new(2023, 7, 2) }

        it 'returns 0' do
          expect(result).to eq(0)
        end
      end

      context 'when the end date day is on the midpoint of days after the start date day' do
        let(:end_date) { Date.new(2023, 7, 3) }

        it 'returns 0.5' do
          expect(result).to eq(0.5)
        end
      end

      context 'when the end date day is just after the midpoint of days after the start date day' do
        let(:end_date) { Date.new(2023, 7, 4) }

        it 'returns 0.5' do
          expect(result).to eq(0.5)
        end
      end

      context 'when the end date day is several days before the end of the start date day' do
        let(:end_date) { Date.new(2023, 7, 9) }

        it 'returns 0.5' do
          expect(result).to eq(0.5)
        end
      end

      context 'when the end date day is the day before one month after the start date day' do
        let(:end_date) { Date.new(2023, 7, 16) }

        it 'returns 0.5' do
          expect(result).to eq(0.5)
        end
      end

      context 'when the end date day is one month after the start date day' do
        let(:end_date) { Date.new(2023, 7, 17) }
        let(:no_of_months) { 4 }

        it 'returns 0' do
          expect(result).to eq(0)
        end
      end
    end

    context 'when the start date day is in the second half of the month' do
      let(:start_date_day) { 24 }

      context 'when the end date day is same as the start date day' do
        let(:end_date) { Date.new(2023, 6, 24) }

        it 'returns 0' do
          expect(result).to eq(0)
        end
      end

      context 'when the end date day is one day after the start date day' do
        let(:end_date) { Date.new(2023, 6, 25) }

        it 'returns 0' do
          expect(result).to eq(0)
        end
      end

      context 'when the end date day is several days after the start date day' do
        let(:end_date) { Date.new(2023, 7, 3) }

        it 'returns 0' do
          expect(result).to eq(0)
        end
      end

      context 'when the end date day is just before the midpoint of days after the start date day' do
        let(:end_date) { Date.new(2023, 7, 9) }

        it 'returns 0' do
          expect(result).to eq(0)
        end
      end

      context 'when the end date day is on the midpoint of days after the start date day' do
        let(:end_date) { Date.new(2023, 7, 10) }

        it 'returns 0.5' do
          expect(result).to eq(0.5)
        end
      end

      context 'when the end date day is just after the midpoint of days after the start date day' do
        let(:end_date) { Date.new(2023, 7, 11) }

        it 'returns 0.5' do
          expect(result).to eq(0.5)
        end
      end

      context 'when the end date day is several days before the end of the start date day' do
        let(:end_date) { Date.new(2023, 7, 16) }

        it 'returns 0.5' do
          expect(result).to eq(0.5)
        end
      end

      context 'when the end date day is the day before one month after the start date day' do
        let(:end_date) { Date.new(2023, 7, 23) }

        it 'returns 0.5' do
          expect(result).to eq(0.5)
        end
      end

      context 'when the end date day is one month after the start date day' do
        let(:end_date) { Date.new(2023, 7, 24) }
        let(:no_of_months) { 4 }

        it 'returns 0' do
          expect(result).to eq(0)
        end
      end
    end

    context 'when the start date day is just before the penultimate day of the month' do
      let(:start_date_day) { 30 }

      context 'when the end date day is same as the start date day' do
        let(:end_date) { Date.new(2023, 6, 30) }

        it 'returns 0' do
          expect(result).to eq(0)
        end
      end

      context 'when the end date day is one day after the start date day' do
        let(:end_date) { Date.new(2023, 7, 1) }

        it 'returns 0' do
          expect(result).to eq(0)
        end
      end

      context 'when the end date day is several days after the start date day' do
        let(:end_date) { Date.new(2023, 7, 9) }

        it 'returns 0' do
          expect(result).to eq(0)
        end
      end

      context 'when the end date day is just before the midpoint of days after the start date day' do
        let(:end_date) { Date.new(2023, 7, 15) }

        it 'returns 0' do
          expect(result).to eq(0)
        end
      end

      context 'when the end date day is on the midpoint of days after the start date day' do
        let(:end_date) { Date.new(2023, 7, 16) }

        it 'returns 0.5' do
          expect(result).to eq(0.5)
        end
      end

      context 'when the end date day is just after the midpoint of days after the start date day' do
        let(:end_date) { Date.new(2023, 7, 17) }

        it 'returns 0.5' do
          expect(result).to eq(0.5)
        end
      end

      context 'when the end date day is several days before the end of the start date day' do
        let(:end_date) { Date.new(2023, 7, 22) }

        it 'returns 0.5' do
          expect(result).to eq(0.5)
        end
      end

      context 'when the end date day is the day before one month after the start date day' do
        let(:end_date) { Date.new(2023, 7, 29) }

        it 'returns 0.5' do
          expect(result).to eq(0.5)
        end
      end

      context 'when the end date day is one month after the start date day' do
        let(:end_date) { Date.new(2023, 7, 30) }
        let(:no_of_months) { 4 }

        it 'returns 0' do
          expect(result).to eq(0)
        end
      end
    end

    context 'when the start date day is the last day of the month' do
      let(:start_date_day) { 31 }

      context 'when the end date day is same as the start date day' do
        let(:end_date) { Date.new(2023, 6, 30) }

        it 'returns 0' do
          expect(result).to eq(0)
        end
      end

      context 'when the end date day is one day after the start date day' do
        let(:end_date) { Date.new(2023, 7, 1) }

        it 'returns 0' do
          expect(result).to eq(0)
        end
      end

      context 'when the end date day is several days after the start date day' do
        let(:end_date) { Date.new(2023, 7, 9) }

        it 'returns 0' do
          expect(result).to eq(0)
        end
      end

      context 'when the end date day is just before the midpoint of days after the start date day' do
        let(:end_date) { Date.new(2023, 7, 15) }

        it 'returns 0' do
          expect(result).to eq(0)
        end
      end

      context 'when the end date day is on the midpoint of days after the start date day' do
        let(:end_date) { Date.new(2023, 7, 16) }

        it 'returns 0.5' do
          expect(result).to eq(0.5)
        end
      end

      context 'when the end date day is just after the midpoint of days after the start date day' do
        let(:end_date) { Date.new(2023, 7, 17) }

        it 'returns 0.5' do
          expect(result).to eq(0.5)
        end
      end

      context 'when the end date day is several days before the end of the start date day' do
        let(:end_date) { Date.new(2023, 7, 22) }

        it 'returns 0.5' do
          expect(result).to eq(0.5)
        end
      end

      context 'when the end date day is the day before one month after the start date day' do
        let(:end_date) { Date.new(2023, 7, 30) }

        it 'returns 0.5' do
          expect(result).to eq(0.5)
        end
      end

      context 'when the end date day is one month after the start date day' do
        let(:end_date) { Date.new(2023, 7, 31) }
        let(:no_of_months) { 4 }

        it 'returns 0' do
          expect(result).to eq(0)
        end
      end
    end
  end

  describe '.one_month_if_needed' do
    let(:result) { one_month_if_needed(end_date, start_date) }

    context 'when the start date is the last day of the month' do
      context 'and the end date is the last day of the month' do
        context 'and start date day is after the end date day' do
          let(:start_date) { Date.new(2023, 4, 30) }
          let(:end_date) { Date.new(2024, 2, 29) }

          it 'returns 0' do
            expect(result).to eq(0)
          end
        end

        context 'and start date day is the same as the end date day' do
          let(:start_date) { Date.new(2023, 4, 30) }
          let(:end_date) { Date.new(2023, 6, 30) }

          it 'returns 0' do
            expect(result).to eq(0)
          end
        end

        context 'and start date day is before the end date day' do
          let(:start_date) { Date.new(2023, 4, 30) }
          let(:end_date) { Date.new(2023, 7, 31) }

          it 'returns 0' do
            expect(result).to eq(0)
          end
        end
      end

      context 'and the end date is not the last day of the month' do
        context 'and start date day is after the end date day' do
          let(:start_date) { Date.new(2023, 4, 30) }
          let(:end_date) { Date.new(2023, 6, 29) }

          it 'returns 1' do
            expect(result).to eq(1)
          end
        end

        context 'and start date day is the same as the end date day' do
          let(:start_date) { Date.new(2023, 4, 30) }
          let(:end_date) { Date.new(2023, 7, 30) }

          it 'returns 0' do
            expect(result).to eq(0)
          end
        end

        context 'and start date day is before the end date day' do
          let(:start_date) { Date.new(2023, 2, 28) }
          let(:end_date) { Date.new(2023, 3, 29) }

          it 'returns 0' do
            expect(result).to eq(0)
          end
        end
      end
    end

    context 'when the start date is the not last day of the month' do
      context 'and the end date is the last day of the month' do
        context 'and start date day is after the end date day' do
          let(:start_date) { Date.new(2023, 5, 30) }
          let(:end_date) { Date.new(2024, 2, 29) }

          it 'returns 0' do
            expect(result).to eq(0)
          end
        end

        context 'and start date day is the same as the end date day' do
          let(:start_date) { Date.new(2023, 4, 29) }
          let(:end_date) { Date.new(2024, 2, 29) }

          it 'returns 0' do
            expect(result).to eq(0)
          end
        end

        context 'and start date day is before the end date day' do
          let(:start_date) { Date.new(2023, 3, 27) }
          let(:end_date) { Date.new(2024, 2, 29) }

          it 'returns 0' do
            expect(result).to eq(0)
          end
        end
      end

      context 'and the end date is not the last day of the month' do
        context 'and start date day is after the end date day' do
          let(:start_date) { Date.new(2023, 5, 25) }
          let(:end_date) { Date.new(2023, 7, 24) }

          it 'returns 1' do
            expect(result).to eq(1)
          end
        end

        context 'and start date day is the same as the end date day' do
          let(:start_date) { Date.new(2023, 5, 25) }
          let(:end_date) { Date.new(2023, 7, 25) }

          it 'returns 0' do
            expect(result).to eq(0)
          end
        end

        context 'and start date day is before the end date day' do
          let(:start_date) { Date.new(2023, 5, 25) }
          let(:end_date) { Date.new(2023, 7, 26) }

          it 'returns 0' do
            expect(result).to eq(0)
          end
        end
      end
    end
  end
  # rubocop:enable RSpec/NestedGroups
end

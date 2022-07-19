require 'rails_helper'

RSpec.describe SupplyTeachers::RM3826::Journey::Results, type: :model do
  describe '.branches' do
    subject(:results) { results_class.new(**params).branches(daily_rates: daily_rates, salary: salary, fixed_term_length: fixed_term_length) }

    let(:first_branch) { create(:supply_teachers_rm3826_branch, :with_rates) }
    let(:second_branch) { create(:supply_teachers_rm3826_branch, :with_rates, :with_extra_rates) }
    let(:branches) { [first_branch, second_branch] }
    let(:postcode) { 'SW1A 1AA' }
    let(:daily_rates) { {} }
    let(:salary) { nil }
    let(:fixed_term_length) { nil }

    before do
      allow(SupplyTeachers::RM3826::Branch).to receive(:search).and_return(branches)

      Geocoder::Lookup::Test.add_stub(
        postcode, [{ 'coordinates' => [51.5149666, -0.119098] }]
      )
    end

    after do
      Geocoder::Lookup::Test.reset
    end

    context 'when on nominated worker results' do
      let(:results_class) { SupplyTeachers::RM3826::Journey::NominatedWorkerResults }
      let(:params) do
        {
          postcode: postcode
        }
      end

      context 'and no daily rate is provided' do
        it 'returns the two branches' do
          expect(results.length).to eq 2

          expect(results.map(&:class).uniq).to eq(
            [SupplyTeachers::BranchSearchResult]
          )

          expect(results.map(&:name)).to eq([first_branch.name, second_branch.name])
        end

        it 'has the correct rates for the branches and the daily_rate is nil' do
          expect(results.map(&:rate)).to eq([0.15, 0.15])
          expect(results.map(&:daily_rate)).to eq([nil, nil])
        end
      end

      context 'and a daily rate is provided' do
        let(:daily_rates) { { first_branch.id => '2000', second_branch.id => '1000' } }

        it 'has the correct rates, daily rates, worker cost and agency fee' do
          expect(results.map(&:daily_rate)).to eq(['2000', '1000'])
          expect(results.map { |result| result.worker_cost.round(2) }).to eq([1739.13, 869.57])
          expect(results.map { |result| result.agency_fee.round(2) }).to eq([260.87, 130.43])
        end
      end
    end

    context 'when on fixed term results' do
      let(:results_class) { SupplyTeachers::RM3826::Journey::FixedTermResults }
      let(:fixed_term_length) { 12 }

      let(:params) do
        {
          postcode: postcode
        }
      end

      context 'when the finders fee is valid' do
        let(:salary) { '1000' }

        it 'returns the two branches' do
          expect(results.length).to eq 2

          expect(results.map(&:class).uniq).to eq(
            [SupplyTeachers::BranchSearchResult]
          )

          expect(results.map(&:name)).to eq([first_branch.name, second_branch.name])
        end

        it 'has the correct rates and finders fee for the branches' do
          expect(results.map(&:rate)).to eq([0.35, 0.35])
          expect(results.map(&:finders_fee)).to eq([350.0, 350.0])
        end
      end

      context 'when the finders fee is invalid' do
        let(:salary) { 'invalid-salary' }

        it 'has the error in the results' do
          expect(results.map(&:error).all?).to be true
        end
      end

      context 'when the salary for a specific branch is passed' do
        let(:salary) { { first_branch.id => '2000' } }

        it 'has the finders fee only for the first branch but the rate for both' do
          expect(results.map(&:rate)).to eq([0.35, 0.35])
          expect(results.map(&:finders_fee)).to eq([700.0, nil])
        end
      end
    end

    context 'when on agency payroll results' do
      let(:results_class) { SupplyTeachers::RM3826::Journey::AgencyPayrollResults }
      let(:job_type) { 'qt' }
      let(:term) { '0_1' }

      let(:params) do
        {
          job_type: job_type,
          term: term,
          postcode: postcode
        }
      end

      # rubocop:disable RSpec/NestedGroups
      context 'and no daily rate is provided' do
        context 'when both suppliers supply the job type for the term' do
          it 'returns the two branches' do
            expect(results.length).to eq 2

            expect(results.map(&:class).uniq).to eq(
              [SupplyTeachers::BranchSearchResult]
            )

            expect(results.map(&:name)).to eq([first_branch.name, second_branch.name])
          end

          it 'has the correct rates for the branches and the daily_rate is nil' do
            expect(results.map(&:rate)).to eq([0.25, 0.25])
            expect(results.map(&:daily_rate)).to eq([nil, nil])
          end
        end

        context 'when one suppliers does the job type for the term' do
          let(:job_type) { 'senior' }
          let(:term) { '0_1' }

          it 'returns the two branches' do
            expect(results.length).to eq 2

            expect(results.map(&:class).uniq).to eq(
              [SupplyTeachers::BranchSearchResult]
            )

            expect(results.map(&:name)).to eq([first_branch.name, second_branch.name])
          end

          it 'has the rate only for the second branch' do
            expect(results.map(&:rate)).to eq([nil, 0.45])
          end
        end
      end
      # rubocop:enable RSpec/NestedGroups

      context 'and a daily rate is provided' do
        let(:daily_rates) { { second_branch.id => '2000' } }

        it 'has the correct rates, daily rates, worker cost and agency fee' do
          expect(results.map(&:daily_rate)).to eq([nil, '2000'])
          expect(results.map(&:worker_cost)).to eq([nil, 1600.0])
          expect(results.map(&:agency_fee)).to eq([nil, 400.0])
        end
      end
    end
  end
end

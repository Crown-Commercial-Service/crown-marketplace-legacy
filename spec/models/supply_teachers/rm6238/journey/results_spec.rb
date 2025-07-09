require 'rails_helper'

RSpec.describe SupplyTeachers::RM6238::Journey::Results do
  describe '.branches' do
    subject(:results) { results_class.new(**params).branches(salary:, fixed_term_length:) }

    let(:supplier_framework_lot_branch_1) { create(:supplier_framework_lot, :with_rates, lot_id: 'RM6238.1', supplier_framework: create(:supplier_framework, framework_id: 'RM6238')) }
    let(:supplier_framework_lot_branch_2) { create(:supplier_framework_lot, :with_rates, :with_extra_rates, lot_id: 'RM6238.1', supplier_framework: create(:supplier_framework, framework_id: 'RM6238')) }
    let(:first_branch) { create(:supplier_framework_lot_branch, supplier_framework_lot: supplier_framework_lot_branch_1) }
    let(:second_branch) { create(:supplier_framework_lot_branch, supplier_framework_lot: supplier_framework_lot_branch_2) }
    let(:branches) { [first_branch, second_branch] }
    let(:postcode) { 'SW1A 1AA' }
    let(:salary) { nil }
    let(:fixed_term_length) { nil }

    before do
      allow(Supplier::Framework::Lot::Branch).to receive(:search).and_return(branches)

      Geocoder::Lookup::Test.add_stub(
        postcode, [{ 'coordinates' => [51.5149666, -0.119098] }]
      )
    end

    after do
      Geocoder::Lookup::Test.reset
    end

    context 'when on nominated worker results' do
      let(:results_class) { SupplyTeachers::RM6238::Journey::NominatedWorkerResults }

      let(:params) do
        {
          postcode:
        }
      end

      it 'returns the two branches' do
        expect(results.length).to eq 2

        expect(results.map(&:class).uniq).to eq(
          [SupplyTeachers::BranchSearchResult]
        )

        expect(results.map(&:name)).to eq([first_branch.name, second_branch.name])
      end

      it 'has the correct rates for the branches' do
        expect(results.map { |result| result.rate.rate }).to eq([1050, 1050])
      end
    end

    context 'when on fixed term results' do
      let(:results_class) { SupplyTeachers::RM6238::Journey::FixedTermResults }
      let(:fixed_term_length) { 12 }

      let(:params) do
        {
          postcode:
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
          expect(results.map { |result| result.rate.rate }).to eq([3050, 3050])
          expect(results.map(&:finders_fee)).to eq([305, 305])
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
          expect(results.map { |result| result.rate.rate }).to eq([3050, 3050])
          expect(results.map(&:finders_fee)).to eq([610.0, nil])
        end
      end
    end

    context 'when on agency payroll results' do
      let(:results_class) { SupplyTeachers::RM6238::Journey::AgencyPayrollResults }

      let(:params) do
        {
          position_id:,
          offset:,
          postcode:
        }
      end

      context 'when both suppliers supply the job type for the term' do
        let(:position_id) { 41 }
        let(:offset) { 0 }

        it 'returns the two branches' do
          expect(results.length).to eq 2

          expect(results.map(&:class).uniq).to eq(
            [SupplyTeachers::BranchSearchResult]
          )

          expect(results.map(&:name)).to eq([first_branch.name, second_branch.name])
        end

        it 'has the correct rates for the branches' do
          expect(results.map { |result| result.rate.rate }).to eq([2050, 2050])
        end
      end

      context 'when one suppliers does the job type for the term' do
        let(:position_id) { 43 }
        let(:offset) { 0 }

        before { allow(Supplier::Framework::Lot::Branch).to receive(:search).and_return([second_branch]) }

        it 'returns the second branch' do
          expect(results.length).to eq 1

          expect(results.map(&:class).uniq).to eq(
            [SupplyTeachers::BranchSearchResult]
          )

          expect(results.map(&:name)).to eq([second_branch.name])
        end

        it 'has the rate only for the second branch' do
          expect(results.map { |result| result.rate.rate }).to eq([4050])
        end
      end
    end
  end
end

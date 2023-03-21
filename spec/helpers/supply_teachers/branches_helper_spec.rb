require 'rails_helper'

RSpec.describe SupplyTeachers::BranchesHelper do
  describe '.show_path' do
    let(:result) { helper.show_path('supplier-name-slug') }

    before { helper.params[:framework] = framework }

    context 'when the framework RM3826' do
      let(:framework) { 'RM3826' }

      it 'returns the path with the right supplier name and framework' do
        expect(result).to eq '/supply-teachers/RM3826/branches/supplier-name-slug'
      end
    end

    context 'when the framework RM6238' do
      let(:framework) { 'RM6238' }

      it 'returns the path with the right supplier name and framework' do
        expect(result).to eq '/supply-teachers/RM6238/branches/supplier-name-slug'
      end
    end
  end

  describe '.fta_calculator_page?' do
    let(:result) { helper.fta_calculator_page? }

    before do
      helper.params[:worker_type] = worker_type
      helper.params[:payroll_provider] = payroll_provider
    end

    context 'when the worker type is agency_supplied' do
      let(:worker_type) { 'agency_supplied' }

      context 'when the payroll provider is school' do
        let(:payroll_provider) { 'school' }

        it 'returns true' do
          expect(result).to be true
        end
      end

      context 'when the payroll provider is not school' do
        let(:payroll_provider) { 'agency' }

        it 'returns false' do
          expect(result).to be false
        end
      end
    end

    context 'when the worker type is not agency_supplied' do
      let(:worker_type) { 'nominated' }

      context 'when the payroll provider is school' do
        let(:payroll_provider) { 'school' }

        it 'returns false' do
          expect(result).to be false
        end
      end

      context 'when the payroll provider is not school' do
        let(:payroll_provider) { 'agency' }

        it 'returns false' do
          expect(result).to be false
        end
      end
    end
  end
end

require 'rails_helper'

RSpec.describe SupplyTeachers::RM3826::CalculationsController, type: :controller do
  let(:default_params) { { service: 'supply_teachers', framework: 'RM3826' } }

  include_context 'and RM6238 is live in the future'

  login_st_buyer

  describe 'GET fta_to_perm_fee' do
    before { get :fta_to_perm_fee, params: params }

    context 'when no transfer fee is required' do
      let(:params) do
        {
          contract_start_date_day: '1',
          contract_start_date_month: '1',
          contract_start_date_year: '2021',
          contract_end_date_day: '1',
          contract_end_date_month: '2',
          contract_end_date_year: '2022',
          looking_for: 'calculate_fta_to_perm_fee'
        }
      end

      it 'sets the end_of_journey' do
        expect(assigns(:end_of_journey)).to be true
      end

      it 'sets the previous step' do
        expect(assigns(:previous_step)).to be_a(SupplyTeachers::RM3826::Journey::FTAToPermContractEnd)
      end

      it 'sets the back_path' do
        expect(assigns(:back_path)).to eq '/supply-teachers/RM3826/fta-to-perm-contract-end?contract_end_date_day=1&contract_end_date_month=2&contract_end_date_year=2022&contract_start_date_day=1&contract_start_date_month=1&contract_start_date_year=2021&looking_for=calculate_fta_to_perm_fee'
      end

      it 'the calculator has no calculations' do
        calculator = assigns(:calculator)

        expect(calculator).to be_a(SupplyTeachers::FTAToPermCalculator::Calculator)

        expect(calculator.current_contract_length).to be nil
        expect(calculator.fixed_term_contract_fee).to be nil
      end

      it 'renders the template' do
        expect(response).to render_template(:fta_to_perm_fee)
      end
    end

    context 'when a transfer fee is required' do
      let(:params) do
        {
          contract_start_date_day: '1',
          contract_start_date_month: '1',
          contract_start_date_year: '2022',
          contract_end_date_day: '1',
          contract_end_date_month: '8',
          contract_end_date_year: '2022',
          hire_date_day: '1',
          hire_date_month: '9',
          hire_date_year: '2022',
          fixed_term_fee: '500',
          looking_for: 'calculate_fta_to_perm_fee'
        }
      end

      it 'sets the end_of_journey' do
        expect(assigns(:end_of_journey)).to be true
      end

      it 'sets the previous step' do
        expect(assigns(:previous_step)).to be_a(SupplyTeachers::RM3826::Journey::FTAToPermFixedTermFee)
      end

      it 'sets the back_path' do
        expect(assigns(:back_path)).to eq '/supply-teachers/RM3826/fta-to-perm-fixed-term-fee?contract_end_date_day=1&contract_end_date_month=8&contract_end_date_year=2022&contract_start_date_day=1&contract_start_date_month=1&contract_start_date_year=2022&fixed_term_fee=500&hire_date_day=1&hire_date_month=9&hire_date_year=2022&looking_for=calculate_fta_to_perm_fee'
      end

      it 'the calculator has no calculations' do
        calculator = assigns(:calculator)

        expect(calculator).to be_a(SupplyTeachers::FTAToPermCalculator::Calculator)

        expect(calculator.current_contract_length).not_to be nil
        expect(calculator.fixed_term_contract_fee).not_to be nil
      end

      it 'renders the template' do
        expect(response).to render_template(:fta_to_perm_fee)
      end
    end
  end
end

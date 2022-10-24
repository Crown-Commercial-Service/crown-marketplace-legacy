require 'rails_helper'

RSpec.describe SupplyTeachers::RM6238::CalculationsController, type: :controller do
  extend APIRequestStubs

  stub_bank_holiday_json

  let(:default_params) { { service: 'supply_teachers', framework: 'RM6238' } }

  login_st_buyer

  describe 'GET temp_to_perm_fee' do
    def request
      get :temp_to_perm_fee, params: {
        looking_for: 'calculate_temp_to_perm_fee',
        daily_fee: '20.55',
        days_per_week: '5',
        contract_start_date_year: '2018',
        contract_start_date_month: '12',
        contract_start_date_day: '1',
        hire_date_year: '2018',
        hire_date_month: '12',
        hire_date_day: '10',
        holiday_1_start_date_year: '2018',
        holiday_1_start_date_month: '12',
        holiday_1_start_date_day: '2',
        holiday_1_end_date_year: '2018',
        holiday_1_end_date_month: '12',
        holiday_1_end_date_day: '3',
        holiday_2_start_date_year: '2018',
        holiday_2_start_date_month: '12',
        holiday_2_start_date_day: '4',
        holiday_2_end_date_year: '2018',
        holiday_2_end_date_month: '12',
        holiday_2_end_date_day: '5'
      }
    end

    # rubocop:disable RSpec/ExampleLength
    it 'calls the calculator with the correct parameters' do
      calculator = instance_double('SupplyTeachers::TempToPermCalculator::Calculator')
      allow(calculator).to receive(:fee).and_return(500)
      allow(SupplyTeachers::TempToPermCalculator::Calculator)
        .to receive(:new)
        .and_return(calculator)

      request

      expect(SupplyTeachers::TempToPermCalculator::Calculator).to have_received(:new).with(
        daily_fee: 20.55,
        days_per_week: 5,
        contract_start_date: Date.new(2018, 12, 1),
        hire_date: Date.new(2018, 12, 10),
        notice_date: nil,
        holiday_1_start_date: Date.new(2018, 12, 2),
        holiday_1_end_date: Date.new(2018, 12, 3),
        holiday_2_start_date: Date.new(2018, 12, 4),
        holiday_2_end_date: Date.new(2018, 12, 5)
      )
    end
    # rubocop:enable RSpec/ExampleLength

    it 'assigns the calculator to the view' do
      request

      expect(assigns(:calculator)).to be_truthy
    end

    it 'renders the template' do
      request

      expect(response).to render_template(:temp_to_perm_fee)
    end
  end

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
        expect(assigns(:previous_step)).to be_a(SupplyTeachers::RM6238::Journey::FTAToPermContractEnd)
      end

      it 'sets the back_path' do
        expect(assigns(:back_path)).to eq '/supply-teachers/RM6238/fta-to-perm-contract-end?contract_end_date_day=1&contract_end_date_month=2&contract_end_date_year=2022&contract_start_date_day=1&contract_start_date_month=1&contract_start_date_year=2021&looking_for=calculate_fta_to_perm_fee'
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
        expect(assigns(:previous_step)).to be_a(SupplyTeachers::RM6238::Journey::FTAToPermFixedTermFee)
      end

      it 'sets the back_path' do
        expect(assigns(:back_path)).to eq '/supply-teachers/RM6238/fta-to-perm-fixed-term-fee?contract_end_date_day=1&contract_end_date_month=8&contract_end_date_year=2022&contract_start_date_day=1&contract_start_date_month=1&contract_start_date_year=2022&fixed_term_fee=500&hire_date_day=1&hire_date_month=9&hire_date_year=2022&looking_for=calculate_fta_to_perm_fee'
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

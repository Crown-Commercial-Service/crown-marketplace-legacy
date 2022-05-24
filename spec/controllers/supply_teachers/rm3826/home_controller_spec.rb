require 'rails_helper'

RSpec.describe SupplyTeachers::RM3826::HomeController, type: :controller do
  let(:default_params) { { service: 'supply_teachers', framework: 'RM3826' } }

  include_context 'and RM6238 is live in the future'

  login_st_buyer

  describe 'GET index' do
    it 'renders the index template' do
      get :index

      expect(response).to render_template(:index)
    end
  end

  describe 'GET temp_to_perm_fee' do
    def request
      get :temp_to_perm_fee, params: {
        looking_for: 'calculate_temp_to_perm_fee',
        day_rate: '600',
        days_per_week: '5',
        contract_start_date_year: '2018',
        contract_start_date_month: '12',
        contract_start_date_day: '1',
        hire_date_year: '2018',
        hire_date_month: '12',
        hire_date_day: '10',
        markup_rate: '30.5',
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
      calculator = instance_double('SupplyTeachers::RM3826::TempToPermCalculator::Calculator')
      allow(calculator).to receive(:fee).and_return(500)
      allow(SupplyTeachers::RM3826::TempToPermCalculator::Calculator)
        .to receive(:new)
        .and_return(calculator)

      request

      expect(SupplyTeachers::RM3826::TempToPermCalculator::Calculator).to have_received(:new).with(
        day_rate: 600,
        days_per_week: 5,
        contract_start_date: Date.new(2018, 12, 1),
        hire_date: Date.new(2018, 12, 10),
        markup_rate: 0.305,
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

  describe 'GET accessibility_statement' do
    it 'renders the accessibility_statement page' do
      get :accessibility_statement

      expect(response).to render_template('home/accessibility/supply_teachers/accessibility_statement')
    end
  end

  describe 'GET cookie_policy' do
    it 'renders the cookie policy page' do
      get :cookie_policy

      expect(response).to render_template('home/cookie_policy')
    end
  end

  describe 'GET cookie_settings' do
    it 'renders the cookie settings page' do
      get :cookie_settings

      expect(response).to render_template('home/cookie_settings')
    end
  end

  describe 'GET not_permitted' do
    it 'renders the not_permitted page' do
      get :not_permitted

      expect(response).to render_template('home/not_permitted')
    end
  end

  describe 'validate service' do
    context 'when the service is not a valid service' do
      let(:default_params) { { service: 'apprenticeships' } }

      it 'renders the erros_not_found page' do
        get :index

        expect(response).to redirect_to errors_404_path
      end
    end
  end
end

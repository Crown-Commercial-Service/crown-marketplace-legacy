require 'rails_helper'

RSpec.describe SupplyTeachers::Admin::UploadsController, type: :controller do
  let(:default_params) { { service: 'supply_teachers/admin' } }

  describe 'GET index' do
    context 'when not logged in' do
      it 'redirects to the gateway' do
        get :index
        expect(response).to redirect_to supply_teachers_gateway_path
      end
    end

    context 'when logged in as a byer' do
      login_st_buyer

      it 'redirects to not permitted' do
        get :index
        expect(response).to redirect_to not_permitted_path(service: 'supply_teachers')
      end
    end

    context 'when logged in as an admin' do
      login_st_admin

      it 'renders the page' do
        get :index
        expect(response).to render_template(:index)
      end
    end
  end

  describe 'GET accessibility_statement' do
    login_st_admin

    it 'renders the accessibility_statement page' do
      get :accessibility_statement
      expect(response).to render_template('supply_teachers/home/accessibility_statement')
    end
  end

  describe 'GET cookies' do
    login_st_admin

    it 'renders the cookies page' do
      get :cookies
      expect(response).to render_template('supply_teachers/home/cookies')
    end
  end

  describe 'validate service' do
    context 'when the service is not a valid service' do
      let(:default_params) { { service: 'apprenticeships/admin' } }

      it 'renders the erros_not_found page' do
        get :index

        expect(response).to redirect_to errors_404_path
      end
    end
  end
end

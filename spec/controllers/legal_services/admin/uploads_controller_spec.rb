require 'rails_helper'

RSpec.describe LegalServices::Admin::UploadsController, type: :controller do
  let(:default_params) { { service: 'legal_services/admin' } }

  describe 'GET index' do
    context 'when not logged in' do
      it 'redirects to the gateway' do
        get :index
        expect(response).to redirect_to legal_services_gateway_path
      end
    end

    context 'when logged in as a byer' do
      login_ls_buyer

      it 'redirects to not permitted' do
        get :index
        expect(response).to redirect_to not_permitted_path(service: 'legal_services')
      end
    end

    context 'when logged in as an admin' do
      login_ls_admin

      it 'renders the page' do
        get :index
        expect(response).to render_template(:index)
      end
    end
  end

  describe 'GET accessibility_statement' do
    login_ls_admin

    it 'renders the accessibility_statement page' do
      get :accessibility_statement
      expect(response).to render_template('legal_services/home/accessibility_statement')
    end
  end

  describe 'GET cookie_policy' do
    login_ls_admin

    it 'renders the cookie policy page' do
      get :cookie_policy
      expect(response).to render_template('home/cookie_policy')
    end
  end

  describe 'GET cookie_settings' do
    login_ls_admin

    it 'renders the cookie settings page' do
      get :cookie_settings
      expect(response).to render_template('home/cookie_settings')
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

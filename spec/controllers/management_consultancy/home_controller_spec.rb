require 'rails_helper'

RSpec.describe ManagementConsultancy::HomeController, type: :controller do
  let(:default_params) { { service: 'management_consultancy' } }

  login_mc_buyer

  describe 'GET index' do
    it 'renders the index template' do
      get :index

      expect(response).to render_template(:index)
    end
  end

  describe 'GET not_permitted' do
    it 'renders the not_permitted page' do
      get :not_permitted
      expect(response).to render_template(:not_permitted)
    end
  end

  describe 'GET cookies' do
    it 'renders the cookies page' do
      get :cookies
      expect(response).to render_template(:cookies)
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

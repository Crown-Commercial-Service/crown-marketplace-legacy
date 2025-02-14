require 'rails_helper'

RSpec.describe ManagementConsultancy::HomeController do
  let(:default_params) { { service: 'management_consultancy' } }

  describe 'GET framework' do
    it 'redirects to the RM6309 home page' do
      get :framework
      # TODO: Update this when the route realy exists
      # expect(response).to redirect_to management_consultancy_rm6309_path
      expect(response).to redirect_to '/management-consultancy/RM6309'
    end
  end

  describe 'GET index' do
    context 'when the framework is not the current framework' do
      it 'renders the unrecognised framework page with the right http status' do
        get :index, params: { framework: 'RM6232' }

        expect(response).to render_template('management_consultancy/home/unrecognised_framework')
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'when the framework is the current framework' do
      # This is because in practice, the rails router will have already used the correct framework controller,
      # therefore, this test is just to make sure that the UnrecognisedLiveFrameworkError is not invoked
      it 'raises the MissingExactTemplate error' do
        expect do
          get :index, params: { framework: 'RM6309' }
        end.to raise_error(ActionController::MissingExactTemplate)
      end
    end
  end

  describe 'validate service' do
    context 'when the service is not a valid service' do
      let(:default_params) { { service: 'apprenticeships' } }

      it 'renders the erros_not_found page' do
        get :framework

        expect(response).to redirect_to errors_404_path
      end
    end
  end
end

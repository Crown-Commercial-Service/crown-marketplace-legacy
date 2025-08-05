require 'rails_helper'

RSpec.describe LegalPanelForGovernment::Admin::HomeController do
  let(:default_params) { { service: 'legal_panel_for_government/admin' } }

  describe 'GET framework' do
    context 'when RM6360 is live' do
      it 'redirects to the RM6360 admin home page' do
        get :framework
        expect(response).to redirect_to legal_panel_for_government_admin_index_path('RM6360')
      end
    end
  end

  describe 'GET index' do
    context 'when RM6360 is live' do
      context 'and the framework is not RM6360' do
        it 'renders the unrecognised framework page with the right http status' do
          get :index, params: { framework: 'RM3826' }

          expect(response).to render_template('home/unrecognised_framework')
          expect(response).to have_http_status(:bad_request)
        end
      end

      # This is because in practice, the rails router will have already used the correct framework controller,
      # therefore, this test is just to make sure that the UnrecognisedLiveFrameworkError is not invoked
      context 'and the framework is RM6360' do
        it 'raises the MissingExactTemplate error' do
          expect do
            get :index, params: { framework: 'RM6360' }
          end.to raise_error(ActionController::MissingExactTemplate)
        end
      end
    end

    context 'when RM6360 is not live' do
      include_context 'and RM6360 is live in the future'

      context 'and the framework is not RM6360' do
        it 'renders the unrecognised framework page with the right http status' do
          get :index, params: { framework: 'RM3826' }

          expect(response).to render_template('home/unrecognised_framework')
          expect(response).to have_http_status(:bad_request)
        end
      end

      context 'and the framework is RM6360' do
        it 'raises the MissingExactTemplate error' do
          expect do
            get :index, params: { framework: 'RM6360' }
          end.to raise_error(ActionController::MissingExactTemplate)
        end
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

require 'rails_helper'

RSpec.describe SupplyTeachers::Admin::HomeController do
  let(:default_params) { { service: 'supply_teachers/admin' } }

  describe 'GET framework' do
    context 'when RM6238 is live' do
      it 'redirects to the RM6238 admin home page' do
        get :framework
        expect(response).to redirect_to supply_teachers_admin_index_path('RM6238')
      end
    end
  end

  describe 'GET index' do
    context 'when RM6238 is live' do
      context 'and the framework is not RM6238' do
        it 'renders the unrecognised framework page with the right http status' do
          get :index, params: { framework: 'RM6187' }

          expect(response).to render_template('home/unrecognised_framework')
          expect(response).to have_http_status(:bad_request)
        end
      end

      # This is because in practice, the rails router will have already used the correct framework controller,
      # therefore, this test is just to make sure that the UnrecognisedLiveFrameworkError is not invoked
      context 'and the framework is RM6238' do
        it 'raises the MissingExactTemplate error' do
          expect do
            get :index, params: { framework: 'RM6238' }
          end.to raise_error(ActionController::MissingExactTemplate)
        end
      end
    end

    context 'when RM6238 is not live' do
      include_context 'and RM6238 is live in the future'

      context 'and the framework is not RM6238' do
        it 'renders the unrecognised framework page with the right http status' do
          get :index, params: { framework: 'RM6187' }

          expect(response).to render_template('home/unrecognised_framework')
          expect(response).to have_http_status(:bad_request)
        end
      end

      context 'and the framework is RM6238' do
        it 'raises the MissingExactTemplate error' do
          expect do
            get :index, params: { framework: 'RM6238' }
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

require 'rails_helper'

RSpec.describe SupplyTeachers::RM6238::GatewayController do
  let(:default_params) { { service: 'supply_teachers', framework: framework } }
  let(:framework) { 'RM6238' }

  describe 'GET index' do
    context 'when not signed in' do
      before { get :index }

      it 'renders the gateway page' do
        expect(response).to render_template(:index)
      end

      context 'when the framework is not the current framework' do
        let(:framework) { 'RM3826' }

        it 'renders the unrecognised framework page with the right http status' do
          expect(response).to render_template('supply_teachers/home/unrecognised_framework')
          expect(response).to have_http_status(:bad_request)
        end
      end
    end

    context 'when signed in' do
      login_st_buyer

      it 'redirects to the framework start page' do
        get :index
        expect(response).to redirect_to(supply_teachers_rm6238_path)
      end
    end
  end
end

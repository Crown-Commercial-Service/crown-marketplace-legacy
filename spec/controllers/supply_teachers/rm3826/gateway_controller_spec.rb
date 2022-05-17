require 'rails_helper'

RSpec.describe SupplyTeachers::RM3826::GatewayController, type: :controller do
  let(:default_params) { { service: 'supply_teachers', framework: framework } }
  let(:framework) { 'RM3826' }

  include_context 'and RM6238 is live in the future'

  describe 'GET index' do
    context 'when not signed in' do
      before { get :index }

      it 'renders the gateway page' do
        expect(response).to render_template(:index)
      end

      context 'when the framework is not the current framework' do
        let(:framework) { 'RM6238' }

        it 'redirects to the framework path' do
          expect(response).to redirect_to supply_teachers_path
        end
      end
    end

    context 'when signed in' do
      login_st_buyer
      it 'redirects to the framework start page' do
        get :index
        expect(response).to redirect_to(supply_teachers_path)
      end
    end
  end
end

require 'rails_helper'

RSpec.describe SupplyTeachers::RM3826::DownloadsController, type: :controller do
  let(:default_params) { { service: 'supply_teachers', framework: framework } }
  let(:framework) { 'RM3826' }

  include_context 'and RM6238 is live in the future'

  describe 'GET index' do
    context 'when not logged in' do
      it 'redirects to gateway page' do
        expect(get(:index)).to redirect_to(supply_teachers_rm3826_gateway_url)
      end
    end

    context 'when logged in as a buyer' do
      login_st_buyer
      it 'redirects to not permitted' do
        get :index, params: { format: 'xlsx' }

        expect(response).to redirect_to '/supply-teachers/RM3826/not-permitted'
      end
    end

    context 'when logged in as an admin' do
      login_st_admin

      before { get :index, params: { format: 'xlsx' } }

      it 'responds to requests for xlsx files' do
        expect(response.media_type)
          .to eq 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
      end

      context 'when the framework is not the current framework' do
        let(:framework) { 'RM6187' }

        it 'renders the unrecognised framework page with the right http status' do
          expect(response).to render_template('home/unrecognised_framework')
          expect(response).to have_http_status(:bad_request)
        end
      end
    end
  end
end

require 'rails_helper'

RSpec.describe SupplyTeachers::DownloadsController, type: :controller do
  let(:default_params) { { service: 'supply_teachers' } }

  describe 'GET index' do
    context 'when not logged in' do
      it 'redirects to gateway page' do
        expect(get(:index)).to redirect_to(supply_teachers_gateway_url)
      end
    end

    context 'when logged in as a buyer' do
      login_st_buyer
      it 'redirects to not permitted' do
        get :index, params: { format: 'xlsx' }

        expect(response).to redirect_to not_permitted_path(service: 'supply_teachers')
      end
    end

    context 'when logged in as an admin' do
      login_st_admin
      it 'responds to requests for xlsx files' do
        get :index, params: { format: 'xlsx' }

        expect(response.media_type)
          .to eq 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
      end
    end
  end
end

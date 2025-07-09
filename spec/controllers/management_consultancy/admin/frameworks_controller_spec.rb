require 'rails_helper'

RSpec.describe ManagementConsultancy::Admin::FrameworksController do
  let(:default_params) { { service: 'management_consultancy/admin' } }

  login_ccs_developer

  describe 'GET index' do
    it 'renders the index page' do
      get :index
      expect(response).to render_template(:index)
    end

    context 'when logged in as a buyer' do
      login_mc_buyer

      it 'redirects to not permitted' do
        get :index
        expect(response).to redirect_to '/management-consultancy/RM6309/admin/not-permitted'
      end
    end

    context 'when logged in as a normal admin' do
      login_mc_admin

      it 'redirects to not permitted' do
        get :index
        expect(response).to redirect_to '/management-consultancy/RM6309/admin/not-permitted'
      end
    end
  end

  describe 'GET edit' do
    let(:framework) { create(:framework) }

    it 'renders the edit page' do
      get :edit, params: { id: framework.id }
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST update' do
    let(:framework) { create(:framework) }
    let(:live_at_yyyy) { framework.live_at.year.to_s }
    let(:live_at_mm) { framework.live_at.month.to_s }
    let(:live_at_dd) { framework.live_at.day.to_s }

    before { post :update, params: { id: framework.id, framework: { live_at_dd:, live_at_mm:, live_at_yyyy: } } }

    context 'when the data is valid' do
      it 'redirects to management_consultancy_admin_frameworks_path' do
        expect(response).to redirect_to management_consultancy_admin_frameworks_path
      end
    end

    context 'when the data is invalid' do
      let(:live_at_mm) { '13' }

      it 'renders the edit page' do
        expect(response).to render_template(:edit)
      end
    end
  end
end

require 'rails_helper'

RSpec.describe LegalPanelForGovernment::RM6360::Admin::SuppliersController do
  let(:default_params) { { service: 'legal_panel_for_government/admin', framework: 'RM6360' } }

  let(:supplier_framework) { create(:supplier_framework, framework_id: 'RM6360') }
  let(:supplier_frameworks) { Supplier::Framework.where(id: supplier_framework.id) }

  describe 'GET index' do
    context 'when not logged in' do
      it 'redirects to the sign-in' do
        get :index
        expect(response).to redirect_to legal_panel_for_government_rm6360_admin_new_user_session_path
      end
    end

    context 'when logged in as a buyer' do
      login_ls_buyer

      it 'redirects to not permitted' do
        get :index
        expect(response).to redirect_to '/legal-panel-for-government/RM6360/admin/not-permitted'
      end
    end

    context 'when logged in as an admin' do
      login_ls_admin

      before { supplier_frameworks }

      it 'renders the page' do
        get :index
        expect(response).to render_template(:index)
      end

      it 'assigns supplier_frameworks' do
        get :index

        assigned_supplier_frameworks = assigns(:supplier_frameworks)

        expect(assigned_supplier_frameworks.count).to eq(1)
        expect(assigned_supplier_frameworks.first.id).to eq(supplier_frameworks.first.id)
      end

      context 'and the framework dose not exist' do
        it 'renders the unrecognised framework page with the right http status' do
          get :index, params: { framework: 'RM3826' }

          expect(response).to render_template('home/unrecognised_framework')
          expect(response).to have_http_status(:bad_request)
        end
      end
    end
  end

  describe 'GET show' do
    login_ls_admin

    before { get :show, params: { id: supplier_framework.id } }

    it 'renders the show template' do
      expect(response).to render_template(:show)
    end

    it 'assigns supplier_frameworks' do
      expect(assigns(:supplier_framework)).to eq(supplier_framework)
    end
  end
end

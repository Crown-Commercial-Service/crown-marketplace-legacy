require 'rails_helper'

RSpec.describe LegalPanelForGovernment::RM6360::Admin::UploadsController do
  let(:default_params) { { service: 'legal_panel_for_government/admin', framework: 'RM6360' } }

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

      it 'renders the page' do
        get :index
        expect(response).to render_template(:index)
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

  describe 'GET accessibility_statement' do
    it 'renders the accessibility_statement page' do
      get :accessibility_statement

      expect(response).to render_template('home/accessibility/legal_panel_for_government/accessibility_statement')
    end
  end

  describe 'GET cookie_policy' do
    it 'renders the cookie policy page' do
      get :cookie_policy

      expect(response).to render_template('home/cookie_policy')
    end
  end

  describe 'GET cookie_settings' do
    it 'renders the cookie settings page' do
      get :cookie_settings

      expect(response).to render_template('home/cookie_settings')
    end
  end

  describe 'PUT update_cookie_settings' do
    let(:cookie_names) { response.cookies.map { |cookie_name, _| cookie_name } }

    before do
      %i[_ga_cookie _gi_cookie _cls_cookie].each do |cookie_name|
        cookies[cookie_name] = { value: 'test_cookie', domain: '.crowncommercial.gov.uk', path: '/' }
      end

      put :update_cookie_settings, params: update_params
    end

    context 'when enableing the ga cookies and disableing the glassbox cookies' do
      let(:update_params) { { ga_cookie_usage: 'true', glassbox_cookie_usage: 'false' } }

      it 'updates the cookie preferences' do
        expect(JSON.parse(response.cookies['cookie_preferences_cmp'])).to eq(
          {
            'settings_viewed' => true,
            'usage' => true,
            'glassbox' => false
          }
        )
      end

      it 'does not delete the ga cookies' do
        %w[_ga_cookie _gi_cookie].each do |cookie_name|
          expect(cookie_names).not_to include cookie_name
        end
      end

      it 'does delete the glassbox cookies' do
        %w[_cls_cookie].each do |cookie_name|
          expect(cookie_names).to include cookie_name

          expect(response.cookies[cookie_name]).to be_nil
        end
      end

      it 'updates the cookies_updated param' do
        expect(controller.params[:cookies_updated]).to be true
      end

      it 'renders the cookie_settings template' do
        expect(response).to render_template('home/cookie_settings')
      end
    end

    context 'when enableing the glassbox cookies and disableing the ga cookies' do
      let(:update_params) { { ga_cookie_usage: 'false', glassbox_cookie_usage: 'true' } }

      it 'updates the cookie preferences' do
        expect(JSON.parse(response.cookies['cookie_preferences_cmp'])).to eq(
          {
            'settings_viewed' => true,
            'usage' => false,
            'glassbox' => true
          }
        )
      end

      it 'does not delete the glassbox cookies' do
        %w[_cls_cookie].each do |cookie_name|
          expect(cookie_names).not_to include cookie_name
        end
      end

      it 'does delete the ga cookies' do
        %w[_ga_cookie _gi_cookie].each do |cookie_name|
          expect(cookie_names).to include cookie_name

          expect(response.cookies[cookie_name]).to be_nil
        end
      end

      it 'updates the cookies_updated param' do
        expect(controller.params[:cookies_updated]).to be true
      end

      it 'renders the cookie_settings template' do
        expect(response).to render_template('home/cookie_settings')
      end
    end

    context 'when enableing the ga cookies and the glassbox cookies' do
      let(:update_params) { { ga_cookie_usage: 'true', glassbox_cookie_usage: 'true' } }

      it 'updates the cookie preferences' do
        expect(JSON.parse(response.cookies['cookie_preferences_cmp'])).to eq(
          {
            'settings_viewed' => true,
            'usage' => true,
            'glassbox' => true
          }
        )
      end

      it 'does not delete the ga and glassbox cookies' do
        %w[_ga_cookie _gi_cookie _cls_cookie].each do |cookie_name|
          expect(cookie_names).not_to include cookie_name
        end
      end

      it 'updates the cookies_updated param' do
        expect(controller.params[:cookies_updated]).to be true
      end

      it 'renders the cookie_settings template' do
        expect(response).to render_template('home/cookie_settings')
      end
    end

    context 'when disableing the ga cookies and the glassbox cookies' do
      let(:update_params) { { ga_cookie_usage: 'false', glassbox_cookie_usage: 'false' } }

      it 'updates the cookie preferences' do
        expect(JSON.parse(response.cookies['cookie_preferences_cmp'])).to eq(
          {
            'settings_viewed' => true,
            'usage' => false,
            'glassbox' => false
          }
        )
      end

      it 'does delete the ga and glassbox cookies' do
        %w[_ga_cookie _gi_cookie _cls_cookie].each do |cookie_name|
          expect(cookie_names).to include cookie_name

          expect(response.cookies[cookie_name]).to be_nil
        end
      end

      it 'updates the cookies_updated param' do
        expect(controller.params[:cookies_updated]).to be true
      end

      it 'renders the cookie_settings template' do
        expect(response).to render_template('home/cookie_settings')
      end
    end
  end

  describe 'GET not_permitted' do
    it 'renders the not_permitted page' do
      get :not_permitted

      expect(response).to render_template('home/not_permitted')
    end
  end

  describe 'validate service' do
    context 'when the service is not a valid service' do
      let(:default_params) { { service: 'apprenticeships/admin' } }

      it 'renders the erros_not_found page' do
        get :index

        expect(response).to redirect_to errors_404_path
      end
    end
  end

  describe 'GET new' do
    login_ls_admin

    it 'renders the new page' do
      get :new

      expect(response).to render_template(:new)
    end
  end

  describe 'POST create' do
    let(:file) { Tempfile.new(['valid_file', '.xlsx']) }
    let(:fake_file) { File.open(file.path) }
    let(:upload) { create(:legal_panel_for_government_rm6360_admin_upload) }

    login_ls_admin

    before do
      allow(upload).to receive(:save).and_return(valid)
      allow(upload).to receive(:save).with(context: :upload).and_return(valid)
      allow(LegalPanelForGovernment::RM6360::Admin::Upload).to receive(:new).with(anything).and_return(upload)
      allow(LegalPanelForGovernment::RM6360::Admin::FileUploadWorker).to receive(:perform_async).with(upload.id).and_return(true)
      post :create, params: { legal_panel_for_government_rm6360_admin_upload: { supplier_details_file: fake_file, supplier_service_offerings_file: fake_file, supplier_other_lots_rate_cards_file: fake_file, supplier_lot_4a_rate_cards_file: fake_file, supplier_lot_4b_rate_cards_file: fake_file, supplier_lot_4c_rate_cards_file: fake_file } }
    end

    after do
      file.unlink
    end

    context 'when the upload is valid' do
      let(:valid) { true }

      it 'redirects to the show page' do
        expect(response).to redirect_to legal_panel_for_government_rm6360_admin_upload_path(upload)
      end

      it 'changes the state to in_progress' do
        expect(upload.in_progress?).to be true
      end
    end

    context 'when the upload is invalid' do
      let(:valid) { false }

      it 'renders the new page' do
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET show' do
    let(:upload) { create(:legal_panel_for_government_rm6360_admin_upload, aasm_state:) }

    login_ls_admin

    before { get :show, params: { id: upload.id } }

    context 'when the upload is published' do
      let(:aasm_state) { 'published' }

      it 'renders the show template' do
        expect(response).to render_template(:show)
      end
    end

    context 'when the upload is in an in progress state' do
      let(:aasm_state) { 'processing_files' }

      render_views

      it 'renders the show template and the in_progress partial' do
        expect(response).to render_template(:show)
        expect(response).to render_template(partial: 'shared/admin/_in_progress')
      end
    end

    context 'when the upload has failed' do
      let(:aasm_state) { 'failed' }

      render_views

      it 'renders the show template and the failed partial' do
        expect(response).to render_template(:show)
        expect(response).to render_template(partial: 'legal_panel_for_government/rm6360/admin/uploads/_failed')
      end
    end
  end

  describe 'GET progress' do
    let(:upload) { create(:legal_panel_for_government_rm6360_admin_upload, aasm_state: 'publishing_data') }

    login_ls_admin

    before { get :progress, params: { upload_id: upload.id } }

    it 'renders the aasm_state as JSON' do
      expect(response.content_type).to eq('application/json; charset=utf-8')
      expect(response.parsed_body).to eq 'import_status' => 'publishing_data'
    end
  end
end

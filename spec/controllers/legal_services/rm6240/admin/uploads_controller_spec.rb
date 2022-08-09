require 'rails_helper'

RSpec.describe LegalServices::RM6240::Admin::UploadsController, type: :controller do
  let(:default_params) { { service: 'legal_services/admin', framework: 'RM6240' } }

  describe 'GET index' do
    context 'when not logged in' do
      it 'redirects to the sign-in' do
        get :index
        expect(response).to redirect_to legal_services_rm6240_admin_new_user_session_path
      end
    end

    context 'when logged in as a buyer' do
      login_ls_buyer

      it 'redirects to not permitted' do
        get :index
        expect(response).to redirect_to '/legal-services/RM6240/admin/not-permitted'
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

      expect(response).to render_template('home/accessibility/legal_services/accessibility_statement')
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
    let(:upload) { create(:legal_services_rm6240_admin_upload) }

    login_ls_admin

    before do
      allow(upload).to receive(:save).and_return(valid)
      allow(upload).to receive(:save).with(context: :upload).and_return(valid)
      allow(LegalServices::RM6240::Admin::Upload).to receive(:new).with(anything).and_return(upload)
      # allow(LegalServices::RM6240::FileUploadWorker).to receive(:perform_async).with(upload.id).and_return(true)
      post :create, params: { legal_services_rm6240_admin_upload: { supplier_details_file: fake_file, supplier_rate_cards_file: fake_file, supplier_lot_1_service_offerings_file: fake_file, supplier_lot_2_service_offerings_file: fake_file, supplier_lot_3_service_offerings_file: fake_file, supplier_lot_4_service_offerings_file: fake_file } }
    end

    after do
      file.unlink
    end

    context 'when the upload is valid' do
      let(:valid) { true }

      pending 'redirects to the show page' do
        expect(response).to redirect_to legal_services_rm6240_admin_upload_path(upload)
      end

      pending 'changes the state to in_progress' do
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
    let(:upload) { create(:legal_services_rm6240_admin_upload, aasm_state: aasm_state) }

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
        expect(response).to render_template(partial: 'legal_services/admin/uploads/_failed')
      end
    end
  end

  describe 'GET progress' do
    let(:upload) { create(:legal_services_rm6240_admin_upload, aasm_state: 'publishing_data') }

    login_ls_admin

    before { get :progress, params: { upload_id: upload.id } }

    it 'renders the aasm_state as JSON' do
      expect(response.content_type).to eq('application/json; charset=utf-8')
      expect(JSON.parse(response.body)).to eq 'import_status' => 'publishing_data'
    end
  end
end

require 'rails_helper'

RSpec.describe ManagementConsultancy::RM6309::Admin::UploadsController do
  let(:default_params) { { service: 'management_consultancy/admin', framework: framework } }
  let(:framework) { 'RM6309' }

  describe 'GET index' do
    context 'when not logged in' do
      it 'redirects to the sign-in' do
        get :index
        expect(response).to redirect_to management_consultancy_rm6309_admin_new_user_session_path
      end
    end

    context 'when logged in as a buyer' do
      login_mc_buyer

      it 'redirects to not permitted' do
        get :index
        expect(response).to redirect_to '/management-consultancy/RM6309/admin/not-permitted'
      end
    end

    context 'when logged in as an admin' do
      login_mc_admin

      it 'renders the page' do
        get :index
        expect(response).to render_template(:index)
      end

      context 'and the framework dose not exist' do
        it 'renders the unrecognised framework page with the right http status' do
          get :index, params: { framework: 'RM3788' }

          expect(response).to render_template('home/unrecognised_framework')
          expect(response).to have_http_status(:bad_request)
        end
      end
    end
  end

  describe 'GET new' do
    login_mc_admin

    it 'renders the new page' do
      get :new

      expect(response).to render_template(:new)
    end
  end

  describe 'POST create' do
    let(:file) { Tempfile.new(['valid_file', '.xlsx']) }
    let(:fake_file) { File.open(file.path) }
    let(:upload) { create(:management_consultancy_rm6309_admin_upload) }

    login_mc_admin

    before do
      allow(upload).to receive(:save).and_return(valid)
      allow(upload).to receive(:save).with(context: :upload).and_return(valid)
      allow(ManagementConsultancy::RM6309::Admin::Upload).to receive(:new).with(anything).and_return(upload)
      allow(ManagementConsultancy::RM6309::Admin::FileUploadWorker).to receive(:perform_async).with(upload.id).and_return(true)
      post :create, params: { management_consultancy_rm6309_admin_upload: { supplier_details_file: fake_file, supplier_rate_cards_file: fake_file, supplier_service_offerings_file: fake_file } }
    end

    after do
      file.unlink
    end

    context 'when the upload is valid' do
      let(:valid) { true }

      it 'redirects to the show page' do
        expect(response).to redirect_to management_consultancy_rm6309_admin_upload_path(upload)
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
    let(:upload) { create(:management_consultancy_rm6309_admin_upload, aasm_state:) }

    login_mc_admin

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
        expect(response).to render_template(partial: 'management_consultancy/rm6309/admin/uploads/_failed')
      end
    end
  end

  describe 'GET progress' do
    let(:upload) { create(:management_consultancy_rm6309_admin_upload, aasm_state: 'publishing_data') }

    login_mc_admin

    before { get :progress, params: { upload_id: upload.id } }

    it 'renders the aasm_state as JSON' do
      expect(response.content_type).to eq('application/json; charset=utf-8')
      expect(response.parsed_body).to eq 'import_status' => 'publishing_data'
    end
  end
end

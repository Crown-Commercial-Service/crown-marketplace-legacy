require 'rails_helper'

RSpec.describe SupplyTeachers::RM3826::Admin::UploadsController, type: :controller do
  let(:default_params) { { service: 'supply_teachers/admin', framework: 'RM3826' } }
  let(:file) { Tempfile.new(['valid_file', '.xlsx']) }
  let(:fake_file) { fixture_file_upload(file.path, 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet') }

  describe 'GET index' do
    context 'when not logged in' do
      it 'redirects to the gateway' do
        get :index
        expect(response).to redirect_to supply_teachers_rm3826_admin_user_session_url
      end
    end

    context 'when logged in as a byer' do
      login_st_buyer

      it 'redirects to not permitted' do
        get :index
        expect(response).to redirect_to '/supply-teachers/RM3826/admin/not-permitted'
      end
    end

    context 'when logged in as an admin' do
      login_st_admin

      it 'renders the page' do
        get :index
        expect(response).to render_template(:index)
      end
    end

    context 'and the framework dose not exist' do
      it 'renders the unrecognised framework page with the right http status' do
        get :index, params: { framework: 'RM6187' }

        expect(response).to render_template('home/unrecognised_framework')
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'GET accessibility_statement' do
    it 'renders the accessibility_statement page' do
      get :accessibility_statement

      expect(response).to render_template('home/accessibility/supply_teachers/accessibility_statement')
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
    context 'when enableing the cookies' do
      before do
        %i[_ga_cookie _gi_cookie _cls_cookie].each do |cookie_name|
          cookies[cookie_name] = { value: 'test_cookie', domain: '.crowncommercial.gov.uk', path: '/' }
        end

        put :update_cookie_settings, params: { ga_cookie_usage: 'true' }
      end

      it 'sets the cookie' do
        expect(cookies[:crown_marketplace_google_analytics_enabled]).to eq('true')

        %i[_ga_cookie _gi_cookie _cls_cookie].each do |cookie_name|
          expect(cookies[cookie_name]).to eq 'test_cookie'
        end
      end

      it 'updates the cookies_updated param' do
        expect(controller.params[:cookies_updated]).to be true
      end

      it 'renders the cookie_settings template' do
        expect(response).to render_template('home/cookie_settings')
      end
    end

    context 'when disabling the cookies' do
      before do
        cookies[:crown_marketplace_google_analytics_enabled] = { value: 'true' }

        %i[_ga_cookie _gi_cookie _cls_cookie].each do |cookie_name|
          cookies[cookie_name] = { value: 'test_cookie', domain: '.crowncommercial.gov.uk', path: '/' }
        end

        put :update_cookie_settings, params: { ga_cookie_usage: 'false' }
      end

      it 'deletes the cookie' do
        %w[_ga_cookie _gi_cookie _cls_cookie crown_marketplace_google_analytics_enabled].each do |cookie_name|
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
    login_st_admin

    it 'renders the new page' do
      get :new

      expect(response).to render_template(:new)
    end
  end

  describe 'POST create' do
    let(:upload) { build(:supply_teachers_rm3826_admin_upload) }

    login_st_admin

    before do
      allow(SupplyTeachers::RM3826::Admin::DataImportWorker).to receive(:perform_async).with(anything).and_return(true)
      post :create, params: { supply_teachers_rm3826_admin_upload: upload_params }
    end

    after do
      file.unlink
    end

    context 'when the upload is valid' do
      let(:upload_params) { { geographical_data_all_suppliers: fake_file } }
      let(:new_upload) { SupplyTeachers::RM3826::Admin::Upload.first }

      it 'redirects to the show page' do
        expect(response).to redirect_to supply_teachers_rm3826_admin_upload_path(new_upload)
      end

      it 'changes the state to processing_files' do
        expect(new_upload.processing_files?).to be true
      end
    end

    context 'when the upload is invalid' do
      let(:upload_params) { {} }

      it 'renders the new page' do
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET show' do
    let(:upload) do
      build(:supply_teachers_rm3826_admin_upload, aasm_state: 'published') do |admin_upload|
        admin_upload.geographical_data_all_suppliers = fake_file
        admin_upload.save
      end
    end

    login_st_admin

    it 'renders the show template' do
      get :show, params: { id: upload.id }

      expect(response).to render_template(:show)
    end
  end

  describe 'PUT update' do
    let(:upload) do
      build(:supply_teachers_rm3826_admin_upload, aasm_state: 'files_processed') do |admin_upload|
        admin_upload.pricing_for_tool = fake_file
        admin_upload.save
      end
    end

    login_st_admin

    before do
      allow(SupplyTeachers::RM3826::Admin::DataUploadWorker).to receive(:perform_async).with(anything).and_return(true)
      put :update, params: { id: upload.id, **update_params }
      upload.reload
    end

    context 'when the upload is approved' do
      let(:update_params) { { approve: 'Publish to live service' } }

      it 'redirects to the show page' do
        expect(response).to redirect_to supply_teachers_rm3826_admin_upload_path(upload)
      end

      it 'changes the state to uploading' do
        expect(upload).to have_state(:uploading)
      end
    end

    context 'when the upload is rejected' do
      let(:update_params) { { reject: 'Cancel session' } }

      it 'redirects to the show page' do
        expect(response).to redirect_to supply_teachers_rm3826_admin_upload_path(upload)
      end

      it 'changes the state to rejected' do
        expect(upload).to have_state(:rejected)
      end
    end

    context 'when the upload is neither approved or rejected' do
      let(:update_params) { {} }

      it 'redirects to the show page' do
        expect(response).to redirect_to supply_teachers_rm3826_admin_upload_path(upload)
      end

      it 'does not change the state' do
        expect(upload).to have_state(:files_processed)
      end
    end
  end

  describe 'DELETE destroy' do
    let(:upload) do
      build(:supply_teachers_rm3826_admin_upload, aasm_state: 'files_processed') do |admin_upload|
        admin_upload.lot_1_and_lot_2_comparisons = fake_file
        admin_upload.save
      end
    end

    login_st_admin

    it 'deletes the upload' do
      delete :destroy, params: { id: upload.id }

      expect { upload.reload }.to raise_error ActiveRecord::RecordNotFound
    end
  end
end

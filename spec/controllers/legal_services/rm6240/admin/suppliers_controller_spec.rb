require 'rails_helper'

RSpec.describe LegalServices::RM6240::Admin::SuppliersController do
  let(:default_params) { { service: 'legal_services/admin', framework: 'RM6240' } }

  let(:supplier) { create(:legal_services_rm6240_admin_supplier) }
  let(:supplier_framework) { create(:supplier_framework, framework_id: 'RM6240', supplier_id: supplier.id) }
  let(:contact_detail) { create(:legal_services_rm6240_admin_supplier_contact_detail, supplier_framework_id: supplier_framework.id) }
  let(:supplier_frameworks) { Supplier::Framework.where(id: supplier_framework.id) }

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

  describe 'GET edit' do
    login_ls_admin

    before do
      supplier
      supplier_framework
      contact_detail

      get :edit, params: { id: supplier_framework.id, section: section }
    end

    shared_examples 'when testing a section' do
      it 'sets supplier_framework' do
        expect(assigns(:supplier_framework)).to be_present
      end

      it 'sets the model' do
        expect(assigns(:model).class).to be(model.class)
      end

      it 'sets section' do
        expect(assigns(:section)).to eq(section)
      end

      it 'sets section_attributes' do
        expect(assigns(:section_attributes)).to eq(section_attributes)
      end

      context 'when considering the templates' do
        render_views

        it 'renders section partial template' do
          expect(response).to have_http_status(:ok)
          expect(response).to render_template(partial: "shared/admin/suppliers/sections/_#{section}")
        end
      end
    end

    context 'when the section is basic_supplier_information' do
      let(:section) { :basic_supplier_information }
      let(:section_attributes) { %i[name duns_number sme] }
      let(:model) { supplier }

      include_context 'when testing a section'
    end

    context 'when the section is supplier_contact_information' do
      let(:section) { :supplier_contact_information }
      let(:section_attributes) { %i[email telephone_number website] }
      let(:model) { contact_detail }

      include_context 'when testing a section'
    end

    context 'when the section is additional_supplier_information' do
      let(:section) { :additional_supplier_information }
      let(:section_attributes) { %i[address lot_1_prospectus_link lot_2_prospectus_link lot_3_prospectus_link] }
      let(:model) { contact_detail }

      include_context 'when testing a section'
    end

    context 'when the section is unexpected' do
      let(:section) { :something_else }

      it 'redirects to the show page' do
        expect(response).to redirect_to("/legal-services/RM6240/admin/suppliers/#{supplier_framework.id}")
      end
    end
  end

  describe 'PUT update' do
    login_ls_admin

    let(:model_param_keys) { model_params.keys }
    let(:expected_updates) { model_params }

    before do
      supplier
      supplier_framework
      contact_detail

      put :update, params: { id: supplier_framework.id, section: section, "#{model.model_name.param_key}": model_params }
    end

    shared_examples 'when testing a section' do
      it 'sets supplier_framework' do
        expect(assigns(:supplier_framework)).to be_present
      end

      it 'sets the model' do
        expect(assigns(:model).class).to be(model.class)
      end

      it 'sets section' do
        expect(assigns(:section)).to eq(section)
      end

      it 'sets section_attributes' do
        expect(assigns(:section_attributes)).to eq(model_params.keys)
      end

      context 'when it is valid' do
        it 'redirects to the show page' do
          expect(response).to redirect_to("/legal-services/RM6240/admin/suppliers/#{supplier_framework.id}")
        end

        it 'updates the details' do
          expect(model.reload.attributes.deep_symbolize_keys.slice(*model_param_keys)).to eq(expected_updates)
        end
      end

      context 'when it is invalid' do
        let(:model_params) { model_params_invalid }

        render_views

        it 'has errors on the model' do
          expect(assigns(:model).errors).to be_present
        end

        it 'renders section partial template' do
          expect(response).to have_http_status(:ok)
          expect(response).to render_template(partial: "shared/admin/suppliers/sections/_#{section}")
        end
      end
    end

    context 'when the section is basic_supplier_information' do
      let(:section) { :basic_supplier_information }

      let(:model) { supplier }
      let(:model_params) { { name: 'Zote the Mighty', duns_number: '123456789', sme: true } }
      let(:model_params_invalid) { { name: '', duns_number: '', sme: '' } }

      include_context 'when testing a section'
    end

    context 'when the section is supplier_contact_information' do
      let(:section) { :supplier_contact_information }

      let(:model) { contact_detail }
      let(:model_params) { { email: 'zote@the.mighty', telephone_number: '07123456789', website: 'https://example.com' } }
      let(:model_params_invalid) { { email: '', telephone_number: '', website: '' } }

      include_context 'when testing a section'
    end

    context 'when the section is additional_supplier_information' do
      let(:section) { :additional_supplier_information }

      let(:model) { contact_detail }
      let(:model_params) { { address: 'Hollow nest', lot_1_prospectus_link: 'https://example.com', lot_2_prospectus_link: 'https://example.com', lot_3_prospectus_link: 'https://example.com' } }
      let(:model_param_keys) { %i[additional_details] }
      let(:expected_updates) { { additional_details: model_params } }
      let(:model_params_invalid) { { address: '', lot_1_prospectus_link: '', lot_2_prospectus_link: '', lot_3_prospectus_link: '' } }

      include_context 'when testing a section'
    end

    context 'when the section is unexpected' do
      let(:section) { :something_else }

      let(:model) { supplier }
      let(:model_params) { { name: 'Zote the Mighty', duns_number: '123456789', sme: true } }

      it 'redirects to the show page' do
        expect(response).to redirect_to("/legal-services/RM6240/admin/suppliers/#{supplier_framework.id}")
      end
    end
  end
end

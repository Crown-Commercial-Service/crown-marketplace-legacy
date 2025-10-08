require 'rails_helper'

RSpec.describe LegalPanelForGovernment::RM6360::BuyerDetailsController do
  let(:default_params) { { service: 'legal_panel_for_government', framework: framework } }
  let(:framework) { 'RM6360' }
  let(:user) { controller.current_user }

  describe 'GET index' do
    context 'when logged in with buyer details' do
      login_ls_buyer_with_details

      before { get :index }

      it 'renders index template' do
        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:index)
      end
    end

    context 'when logged in without buyer details' do
      login_ls_buyer

      before { get :index }

      it 'redirects to the edit page' do
        expect(response).to redirect_to("/legal-panel-for-government/RM6360/buyer-details/#{user.buyer_detail.id}")
      end
    end

    context 'when the framework is not recognised' do
      login_ls_buyer_with_details

      let(:framework) { 'RM3840' }

      before { get :index }

      it 'renders the unrecognised framework page with the right http status' do
        expect(response).to render_template('home/unrecognised_framework')
        expect(response).to have_http_status(:bad_request)
      end

      it 'sets the framework variables' do
        expect(assigns(:unrecognised_framework)).to eq 'RM3840'
        expect(controller.params[:framework]).to eq Framework.legal_panel_for_government.current_framework
      end
    end
  end

  describe 'GET show' do
    login_ls_buyer_with_details

    before { get :show, params: { id: user.id } }

    it 'renders show template' do
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:show)
    end

    it 'sets buyer_detail' do
      expect(assigns(:buyer_detail)).to be_present
    end
  end

  describe 'GET edit' do
    login_ls_buyer_with_details

    before { get :edit, params: { id: user.buyer_detail.id, section: section } }

    shared_examples 'when testing a section' do
      it 'sets buyer_detail' do
        expect(assigns(:buyer_detail)).to be_present
      end

      context 'when considering the templates' do
        render_views

        it 'renders section partial template' do
          expect(response).to have_http_status(:ok)
          expect(response).to render_template(partial: "buyer_details/sections/_#{section}")
        end
      end
    end

    context 'when the section is personal_details' do
      let(:section) { :personal_details }

      include_context 'when testing a section'
    end

    context 'when the section is organisation_details' do
      let(:section) { :organisation_details }

      include_context 'when testing a section'
    end

    context 'when the section is unexpected' do
      let(:section) { :something_else }

      it 'redirects to the show page' do
        expect(response).to redirect_to("/legal-panel-for-government/RM6360/buyer-details/#{user.buyer_detail.id}")
      end
    end
  end

  describe 'PUT update' do
    login_ls_buyer_with_details

    before { put :update, params: { id: user.buyer_detail.id, section: section, buyer_detail: buyer_detail } }

    shared_examples 'when testing a section' do
      it 'sets buyer_detail' do
        expect(assigns(:buyer_detail)).to be_present
      end

      context 'when it is valid' do
        it 'redirects to the show page' do
          expect(response).to redirect_to("/legal-panel-for-government/RM6360/buyer-details/#{user.buyer_detail.id}")
        end

        it 'updates the buyer details' do
          expect(user.reload.buyer_detail.attributes.deep_symbolize_keys.slice(*buyer_detail.keys)).to eq(buyer_detail)
        end
      end

      context 'when it is invalid' do
        let(:buyer_detail) { buyer_detail_invalid }

        render_views

        it 'has errors on the buyer detail' do
          expect(assigns(:buyer_detail).errors).to be_present
        end

        it 'renders section partial template' do
          expect(response).to have_http_status(:ok)
          expect(response).to render_template(partial: "buyer_details/sections/_#{section}")
        end
      end
    end

    context 'when the section is personal_details' do
      let(:section) { :personal_details }

      let(:buyer_detail) { { name: 'Zote the Mighty', job_title: 'Knight' } }
      let(:buyer_detail_invalid) { { name: '', job_title: '' } }

      include_context 'when testing a section'
    end

    context 'when the section is organisation_details' do
      let(:section) { :organisation_details }

      let(:buyer_detail) { { organisation_name: 'The Knight', organisation_sector: 'defence_and_security' } }
      let(:buyer_detail_invalid) { { organisation_name: '', organisation_sector: '' } }

      include_context 'when testing a section'
    end

    context 'when the section is unexpected' do
      let(:section) { :something_else }

      let(:buyer_detail) { { name: 'Zote the Mighty', job_title: 'Knight' } }

      it 'redirects to the show page' do
        expect(response).to redirect_to("/legal-panel-for-government/RM6360/buyer-details/#{user.buyer_detail.id}")
      end
    end
  end
end

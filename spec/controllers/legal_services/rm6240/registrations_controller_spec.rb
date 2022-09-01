require 'rails_helper'

RSpec.describe LegalServices::RM6240::RegistrationsController, type: :controller do
  let(:default_params) { { service: 'legal_services', framework: 'RM6240' } }

  before { request.env['devise.mapping'] = Devise.mappings[:user] }

  describe 'GET new' do
    before { get :new }

    render_views

    it 'renders the new page' do
      expect(response).to render_template(:new)
    end

    it 'gives the user the buyer and ls_access roles' do
      expect(assigns(:result).roles).to eq(%i[buyer ls_access])
    end
  end

  describe 'POST create' do
    let(:email) { 'test@testemail.com' }
    let(:password) { 'Password890!' }
    let(:password_confirmation) { password }

    context 'when no exception is raised' do
      before do
        # rubocop:disable RSpec/AnyInstance
        allow_any_instance_of(Cognito::SignUpUser).to receive(:create_cognito_user).and_return({ 'user_sub': '1234567890' })
        allow_any_instance_of(Cognito::SignUpUser).to receive(:add_user_to_groups).and_return(true)
        allow_any_instance_of(AllowedEmailDomain).to receive(:allow_list).and_return(['testemail.com'])
        # rubocop:enable RSpec/AnyInstance
        post :create, params: { user: { email: email, password: password, password_confirmation: password_confirmation } }
        cookies.update(response.cookies)
      end

      context 'when the emaildomain is not on the allow list' do
        let(:email) { 'test@fake-testemail.com' }

        it 'redirects to legal_services_rm6240_domain_not_on_safelist_path' do
          expect(response).to redirect_to legal_services_rm6240_domain_not_on_safelist_path
        end
      end

      context 'when some of the information is invalid' do
        let(:password_confirmation) { 'I do not match the password' }

        it 'renders the new page' do
          expect(response).to render_template(:new)
        end
      end

      context 'when all the information is valid' do
        it 'redirects to legal_services_rm6240_users_confirm_path' do
          expect(response).to redirect_to legal_services_rm6240_users_confirm_path
        end

        it 'sets the crown_marketplace_confirmation_email cookie' do
          expect(cookies[:crown_marketplace_confirmation_email]).to eq email
        end
      end
    end

    context 'when an exception is raised' do
      before do
        # rubocop:disable RSpec/AnyInstance
        allow_any_instance_of(Cognito::SignUpUser).to receive(:create_cognito_user).and_raise(error.new('Some context', 'Some message'))
        allow_any_instance_of(Cognito::SignUpUser).to receive(:add_user_to_groups).and_return(true)
        allow_any_instance_of(AllowedEmailDomain).to receive(:allow_list).and_return(['testemail.com'])
        # rubocop:enable RSpec/AnyInstance
        post :create, params: { user: { email: email, password: password, password_confirmation: password_confirmation } }
        cookies.update(response.cookies)
      end

      context 'and the error is UsernameExistsException' do
        let(:error) { Aws::CognitoIdentityProvider::Errors::UsernameExistsException }

        it 'redirects to legal_services_rm6240_users_confirm_path' do
          expect(response).to redirect_to legal_services_rm6240_users_confirm_path
        end

        it 'sets the crown_marketplace_confirmation_email cookie' do
          expect(cookies[:crown_marketplace_confirmation_email]).to eq email
        end
      end

      context 'and the error is InvalidParameterException' do
        let(:error) { Aws::CognitoIdentityProvider::Errors::InvalidParameterException }

        it 'renders the new page' do
          expect(response).to render_template(:new)
        end
      end
    end
  end

  describe 'GET domain_not_on_safelist' do
    before { get :domain_not_on_safelist }

    render_views

    it 'renders the new page' do
      expect(response).to render_template(:domain_not_on_safelist)
    end
  end
end

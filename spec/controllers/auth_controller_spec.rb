require 'rails_helper'

RSpec.describe AuthController do
  describe 'GET #callback' do
    before do
      OmniAuth.config.test_mode = false
      OmniAuth.config.mock_auth[:dfe] = nil
      request.env['omniauth.auth'] = {
        'info' => {
          'email' => email
        },
        'provider' => 'dfe',
        'extra' => {
          'raw_info' => {
            'organisation' => {
              'id' => '047F32E7-FDD5-46E9-89D4-2498C2E77364',
              'name' => 'St Custard’s',
              'urn' => '900002',
              'ukprn' => '90000002',
              'category' => {
                'id' => '001',
                'name' => 'Establishment'
              },
              'type' => {
                'id' => '01',
                'name' => 'Community school'
              }
            }
          }
        }
      }

      controller.instance_eval do
        session[:requested_path] = '/REQUESTED'
      end
    end

    context 'and the user does not exit' do
      let(:email) { 'dfe@example.com' }

      it 'creates the user' do
        expect { get :callback }.to change(User, :count).by(1)
      end

      it 'stores the email in the session' do
        get :callback

        expect(controller.current_user.email).to eq('dfe@example.com')
      end

      it 'redirects to the page stored in the session' do
        get :callback

        expect(response).to redirect_to('/REQUESTED')
      end
    end

    context 'and the user already exits' do
      let!(:existing_user) { create(:user, email: email, roles: %i[buyer st_access]) }

      context 'and the email does not contain any uppercase letters' do
        let(:email) { 'dfe@example.com' }

        it 'does not create the user' do
          expect { get :callback }.not_to change(User, :count)
        end

        it 'gets the correct user' do
          get :callback

          expect(controller.current_user).to eq(existing_user)
        end

        it 'redirects to the page stored in the session' do
          get :callback

          expect(response).to redirect_to('/REQUESTED')
        end
      end

      context 'and the email does contain uppercase letters' do
        let(:email) { 'DfE@example.com' }

        it 'does not create the user' do
          expect { get :callback }.not_to change(User, :count)
        end

        it 'gets the correct user' do
          get :callback

          expect(controller.current_user).to eq(existing_user)
        end

        it 'redirects to the page stored in the session' do
          get :callback

          expect(response).to redirect_to('/REQUESTED')
        end
      end
    end
  end
end

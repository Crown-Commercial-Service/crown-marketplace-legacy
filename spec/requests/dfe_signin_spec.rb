require 'rails_helper'

RSpec.describe 'DfE sign-in' do
  describe 'GET /auth/dfe/callback' do
    it 'redirects to dfe sign in when requested outside of openid connect exchange' do
      OmniAuth.config.test_mode = false

      get '/auth/dfe/callback'

      expect(response).to redirect_to('/auth/dfe')
    end
  end
end

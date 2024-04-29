def stub_login
  aws_client = instance_double(Aws::CognitoIdentityProvider::Client)
  allow(Aws::CognitoIdentityProvider::Client).to receive(:new).and_return(aws_client)
  allow(aws_client).to receive(:initiate_auth).and_return(COGNITO_RESPONSE_STRUCTS[:initiate_auth].new)
  allow_any_instance_of(Cognito::SignInUser).to receive(:sleep)
end

def create_admin_user(service)
  role = :"#{service}_access"
  @user = create(:user, confirmed_at: Time.zone.now, roles: [:buyer, :ccs_employee, role])
  allow_any_instance_of(Cognito::UpdateUser).to receive(:call).and_return(true)
  allow_any_instance_of(Cognito::UpdateUser).to receive(:call).with(anything).and_return(true)
  stub_login
end

def create_buyer_user(service)
  role = :"#{service}_access"
  @user = create(:user, confirmed_at: Time.zone.now, roles: [:buyer, role])
  allow_any_instance_of(Cognito::UpdateUser).to receive(:call).and_return(true)
  allow_any_instance_of(Cognito::UpdateUser).to receive(:call).with(anything).and_return(true)
  stub_login
end

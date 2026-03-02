RSpec.shared_context 'with cognito structs' do
  # Response structs
  let(:admin_create_user_resp_struct) { Struct.new(:user) }
  let(:admin_list_groups_for_user_resp_struct) { Struct.new(:groups) }
  let(:admin_get_user_resp_struct) { Struct.new(:user_attributes, :enabled, :user_status, :user_mfa_setting_list) }
  # rubocop:disable Naming/MethodName
  let(:forgot_password_resp_struct) { Struct.new(:USER_ID_FOR_SRP) }
  # rubocop:enable Naming/MethodName
  let(:initiate_auth_resp_struct) { Struct.new(:challenge_name, :session, :challenge_parameters) }
  let(:list_users_resp_struct) { Struct.new(:users) }
  let(:resend_confirmation_code_resp_struct) { forgot_password_resp_struct }
  let(:respond_to_auth_challenge_resp_struct) { Struct.new(:challenge_name, :session) }

  # Cogntio structs
  let(:cognito_group_struct) { Struct.new(:group_name) }
  let(:cognito_session_struct) { Struct.new(:session) }
  let(:cognito_user_attribute_struct) { Struct.new(:name, :value) }
  let(:cognito_user_struct) { Struct.new(:username, :enabled, :attributes) }
end

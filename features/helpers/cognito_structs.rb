COGNITO_RESPONSE_STRUCTS = {
  admin_create_user: Struct.new(:user),
  admin_list_groups_for_user: Struct.new(:groups),
  admin_get_user: Struct.new(:user_attributes, :enabled, :user_status, :user_mfa_setting_list),
  initiate_auth: Struct.new(:challenge_name, :session, :challenge_parameters),
  list_users: Struct.new(:users),
  respond_to_auth_challenge: Struct.new(:challenge_name, :session)
}.freeze

COGNITO_OBJECT_STRUCTS = {
  cognito_group: Struct.new(:group_name),
  cognito_user_attribute: Struct.new(:name, :value),
  cognito_user: Struct.new(:username, :enabled, :attributes)
}.freeze

require 'rails_helper'

RSpec.feature 'Authentication' do
  include_context 'with cognito structs'

  let(:aws_client) { instance_double(Aws::CognitoIdentityProvider::Client) }
  let(:cognito_groups) do
    admin_list_groups_for_user_resp_struct.new(
      groups: [
        cognito_group_struct.new(group_name: 'buyer'),
        cognito_group_struct.new(group_name: 'st_access'),
        cognito_group_struct.new(group_name: 'mc_access')
      ]
    )
  end

  before do
    allow(Aws::CognitoIdentityProvider::Client).to receive(:new).and_return(aws_client)
    allow(aws_client).to receive_messages(initiate_auth: initiate_auth_resp_struct.new(session: '1234667'), admin_list_groups_for_user: cognito_groups)
    # rubocop:disable RSpec/AnyInstance
    allow_any_instance_of(Cognito::SignInUser).to receive(:sleep)
    # rubocop:enable RSpec/AnyInstance
    create_cookie('foo', 'bar')
  end

  scenario 'Unauthenticated users cannot access protected pages' do
    OmniAuth.config.test_mode = false
    visit '/legal-services/RM6240/start'

    expect(page).to have_text('Sign in to your legal services account')
  end

  scenario 'Users can sign in using AWS Cognito' do
    OmniAuth.config.test_mode = false
    user = create(:user, roles: %i[buyer mc_access])
    visit '/legal-services/RM6240/start'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'ValidPassword!'
    click_button 'Sign in'
    expect(page).to have_no_text('Not permitted')
    expect(page).to have_text('Do you work for central government?')
  end

  scenario 'Users can sign in using AWS Cognito with capitals in email' do
    user = create(:user, roles: %i[buyer mc_access])
    visit '/legal-services/RM6240/start'
    fill_in 'Email', with: user.email.upcase
    fill_in 'Password', with: 'ValidPassword!'
    click_button 'Sign in'
    expect(page).to have_no_text('Not permitted')
    expect(page).to have_text('Do you work for central government?')
  end

  scenario 'Users signed in using AWS Cognito can sign out' do
    user = create(:user, roles: %i[buyer mc_access])
    visit '/legal-services/RM6240/start'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'ValidPassword!'
    click_button 'Sign in'
    click_on 'Sign out'

    visit '/legal-services/RM6240/start'
    expect(page).to have_text('Sign in to your legal services account')
  end

  scenario 'Users can sign in using DfE sign-in', :dfe do
    visit '/supply-teachers/RM6238/start'
    click_on 'Sign in with DfE Sign-in'

    expect(page).to have_no_text('Not permitted')
    expect(page).to have_text('Find supply teachers')
  end

  scenario 'Users signed in using DfE sign-in can sign out', :dfe do
    visit '/supply-teachers/RM6238/start'
    click_on 'Sign in with DfE Sign-in'
    click_on 'Sign out'

    visit '/supply-teachers/RM6238/start'

    expect(page).to have_text('Sign in with DfE Sign-in')
  end

  scenario 'DfE users cannot see other frameworks', :dfe do
    visit '/supply-teachers/RM6238/start'
    click_on 'Sign in with DfE Sign-in'

    visit '/legal-services/RM6240/start'

    expect(page).to have_text(I18n.t('home.not_permitted.title'))
  end

  # rubocop:disable RSpec/ExampleLength
  scenario 'DfE users cannot see school pages if they are from a for-profit school' do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:dfe] = OmniAuth::AuthHash.new(
      'provider' => 'dfe',
      'info' => { 'email' => 'dfe@example.com' },
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
              'id' => '11',
              'name' => 'Other independent school'
            }
          }
        }
      }
    )

    visit '/supply-teachers/RM6238/start'

    click_on 'Sign in with DfE Sign-in'

    expect(page).to have_text(I18n.t('home.not_permitted.title'))
    OmniAuth.config.mock_auth[:dfe] = nil
  end
  # rubocop:enable RSpec/ExampleLength

  scenario 'DfE users cannot see school pages if they are not on the safelist', :dfe do
    allow(Marketplace)
      .to receive_messages(dfe_signin_safelist_enabled?: true, dfe_signin_safelisted_email_addresses: [])
    visit '/supply-teachers/RM6238/start'
    click_on 'Sign in with DfE Sign-in'

    expect(page).to have_text(I18n.t('home.not_permitted.title'))
  end
end

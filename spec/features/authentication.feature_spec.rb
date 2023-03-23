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
    allow(aws_client).to receive(:initiate_auth).and_return(initiate_auth_resp_struct.new(session: '1234667'))
    allow(aws_client).to receive(:admin_list_groups_for_user).and_return(cognito_groups)
    # rubocop:disable RSpec/AnyInstance
    allow_any_instance_of(Cognito::SignInUser).to receive(:sleep)
    # rubocop:enable RSpec/AnyInstance
    create_cookie('foo', 'bar')
  end

  scenario 'Unauthenticated users cannot access protected pages' do
    OmniAuth.config.test_mode = false
    visit '/management-consultancy/RM6187/start'

    expect(page).to have_text('Sign in to your management consultancy account')
  end

  scenario 'Users can sign in using AWS Cognito' do
    OmniAuth.config.test_mode = false
    user = create(:user, roles: %i[buyer mc_access])
    visit '/management-consultancy/RM6187/start'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'ValidPassword!'
    click_button 'Sign in'
    expect(page).not_to have_text('Not permitted')
    expect(page).to have_text('Important changes to how you access Management Consultancy Framework Three')
  end

  scenario 'Users can sign in using AWS Cognito with capitals in email' do
    user = create(:user, roles: %i[buyer mc_access])
    visit '/management-consultancy/RM6187/start'
    fill_in 'Email', with: user.email.upcase
    fill_in 'Password', with: 'ValidPassword!'
    click_button 'Sign in'
    expect(page).not_to have_text('Not permitted')
    expect(page).to have_text('Important changes to how you access Management Consultancy Framework Three')
  end

  scenario 'Users signed in using AWS Cognito can sign out' do
    user = create(:user, roles: %i[buyer mc_access])
    visit '/management-consultancy/RM6187/start'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'ValidPassword!'
    click_button 'Sign in'
    click_on 'Sign out'

    visit '/management-consultancy/RM6187/start'
    expect(page).to have_text('Sign in to your management consultancy account')
  end

  scenario 'Users can sign in using DfE sign-in', dfe: true do
    visit '/supply-teachers/RM6238/start'
    click_on 'Sign in with DfE Sign-in'

    expect(page).not_to have_text('Not permitted')
    expect(page).to have_text('Find supply teachers')
  end

  scenario 'Users signed in using DfE sign-in can sign out', dfe: true do
    visit '/supply-teachers/RM6238/start'
    click_on 'Sign in with DfE Sign-in'
    click_on 'Sign out'

    visit '/supply-teachers/RM6238/start'

    expect(page).to have_text('Sign in with DfE Sign-in')
  end

  scenario 'DfE users cannot see other frameworks', dfe: true do
    visit '/supply-teachers/RM6238/start'
    click_on 'Sign in with DfE Sign-in'

    visit '/management-consultancy/RM6187/start'

    expect(page).to have_text(I18n.t('home.not_permitted.title'))
  end

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

  scenario 'DfE users cannot see school pages if they are not on the safelist', dfe: true do
    allow(Marketplace)
      .to receive(:dfe_signin_safelist_enabled?)
      .and_return(true)
    allow(Marketplace)
      .to receive(:dfe_signin_safelisted_email_addresses)
      .and_return([])
    visit '/supply-teachers/RM6238/start'
    click_on 'Sign in with DfE Sign-in'

    expect(page).to have_text(I18n.t('home.not_permitted.title'))
  end
end

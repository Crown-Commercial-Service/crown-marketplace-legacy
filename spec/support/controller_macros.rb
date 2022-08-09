module ControllerMacros
  def login_st_buyer
    before do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user = FactoryBot.create(:user, confirmed_at: Time.zone.now, roles: %i[buyer st_access])
      sign_in user
    end
  end

  def login_st_admin
    before do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user = FactoryBot.create(:user, confirmed_at: Time.zone.now, roles: %i[ccs_employee st_access])
      sign_in user
    end
  end

  def login_mc_admin
    before do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user = FactoryBot.create(:user, confirmed_at: Time.zone.now, roles: %i[ccs_employee mc_access])
      sign_in user
    end
  end

  def login_mc_buyer
    before do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user = FactoryBot.create(:user, confirmed_at: Time.zone.now, roles: %i[buyer mc_access])
      sign_in user
    end
  end

  def login_mc_buyer_with_detail
    before do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user = FactoryBot.create(:user, confirmed_at: Time.zone.now, roles: %i[buyer mc_access])
      sign_in user
    end
  end

  def login_st_buyer_with_detail
    before do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user = FactoryBot.create(:user, :with_detail, confirmed_at: Time.zone.now, roles: %i[buyer st_access])
      sign_in user
    end
  end

  def login_ls_admin
    before do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user = FactoryBot.create(:user, confirmed_at: Time.zone.now, roles: %i[ccs_employee ls_access])
      sign_in user
    end
  end

  def login_ls_buyer
    before do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user = FactoryBot.create(:user, confirmed_at: Time.zone.now, roles: %i[buyer ls_access])
      sign_in user
    end
  end

  def login_fm_supplier
    before do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user = FactoryBot.create(:user, confirmed_at: Time.zone.now, roles: %i[supplier fm_access])
      sign_in user
    end
  end

  def login_ccs_developer
    before do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user = FactoryBot.create(:user, confirmed_at: Time.zone.now, roles: %i[ccs_employee ccs_developer])
      sign_in user
    end
  end
end

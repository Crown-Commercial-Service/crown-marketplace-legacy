class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    cannot :manage, :all

    if user.has_role? :ccs_employee
      can :read, :all

      super_admin_specific_auth(user)
      service_admin_specific_auth(user)
    else
      service_specific_auth(user)
    end
  end

  private

  def service_specific_auth(user)
    if user.has_any_role? :mc_access, :ls_access
      can :read, ManagementConsultancy
      can :read, LegalServices
      can :read, LegalPanelForGovernment
    end
    can :read, SupplyTeachers if user.has_role? :st_access
  end

  def service_admin_specific_auth(user)
    can :manage, ManagementConsultancy::Admin if user.has_role? :mc_access
    can :manage, LegalServices::Admin if user.has_role? :ls_access
    can :manage, LegalPanelForGovernment::Admin if user.has_role? :ls_access
    can :manage, SupplyTeachers::Admin if user.has_role? :st_access
  end

  def super_admin_specific_auth(user)
    can :manage, Framework if user.has_role? :ccs_developer
  end
end

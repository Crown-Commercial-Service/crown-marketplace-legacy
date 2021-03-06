class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    cannot :manage, :all
    if user.has_role? :ccs_admin
      can :manage, :all
    elsif user.has_role? :ccs_employee
      admin_tool_specific_auth(user)
    else
      service_specific_auth(user)
    end
  end

  private

  def service_specific_auth(user)
    if user.has_any_role? :mc_access, :ls_access
      can :read, ManagementConsultancy
      can :read, LegalServices
    end
    can :read, SupplyTeachers if user.has_role? :st_access
  end

  def admin_tool_specific_auth(user)
    can :read, :all
    if user.has_any_role? :mc_access, :ls_access
      can :manage, ManagementConsultancy::Admin::Upload
      can :manage, LegalServices::Admin::Upload
    end
    can :manage, SupplyTeachers::Admin::Upload if user.has_role? :st_access
  end
end

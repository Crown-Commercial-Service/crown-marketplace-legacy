class User < ApplicationRecord
  include RoleModel

  has_many :searches, inverse_of: :user, dependent: :destroy
  has_many :reports, inverse_of: :user, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :trackable and :omniauthable
  devise :registerable, :recoverable, :timeoutable

  def authenticatable_salt
    "#{id}#{session_token}"
  end

  def invalidate_session!
    self.session_token = SecureRandom.hex
  end

  roles_attribute :roles_mask

  # declare the valid roles -- do not change the order if you add more
  # roles later, always append them at the end!
  roles :buyer, :supplier, :ccs_employee, :ccs_admin, :st_access, :ls_access, :mc_access, :ccs_developer

  attr_accessor :password, :password_confirmation

  def confirmed?
    confirmed_at.present?
  end
end

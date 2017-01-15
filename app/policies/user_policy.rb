class UserPolicy < ApplicationPolicy
  def new?
    create?
  end

  def create?
    user.admin?
  end
end

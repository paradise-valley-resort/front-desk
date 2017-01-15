class UserPolicy < ApplicationPolicy
  def new?
    create?
  end

  def create?
    user.admin?
  end

  def edit?
    update?
  end

  def update?
    user.admin?
  end
end

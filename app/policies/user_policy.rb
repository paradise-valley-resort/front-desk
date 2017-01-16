class UserPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

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

  def deactivate?
    user.admin? && user != record
  end

  def demote?
    user.admin? && user != record
  end
end

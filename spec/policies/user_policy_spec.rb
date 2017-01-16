require "rails_helper"

describe UserPolicy do
  subject { described_class }

  permissions :index?, :new?, :create?, :edit?, :update?, :demote? do
    it "denies access when not an admin" do
      expect(subject).not_to permit(build(:user), User)
    end

    it "grants acces when an admin" do
      expect(subject).to permit(build(:user, :admin), User)
    end
  end

  permissions :demote? do
    it "denies access when admin attempts to demote himself" do
      admin = build(:user, :admin)

      expect(subject).not_to permit(admin, admin)
    end

    it "grants access when admin demotes other user" do
      admin = build(:user, :admin)

      expect(subject).to permit(admin, User)
    end
  end
end

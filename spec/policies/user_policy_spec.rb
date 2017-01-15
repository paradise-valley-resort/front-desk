require "rails_helper"

describe UserPolicy do
  subject { described_class }

  permissions :index?, :new?, :create?, :edit?, :update? do
    it "denies access when not an admin" do
      expect(subject).not_to permit(build(:user), User)
    end

    it "grants acces when an admin" do
      expect(subject).to permit(build(:user, :admin), User)
    end
  end
end

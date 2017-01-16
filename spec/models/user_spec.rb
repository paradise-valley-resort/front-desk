require "rails_helper"

describe User do
  describe "validation" do
    it { should validate_length_of(:first_name).is_at_most(255) }
    it { should validate_length_of(:last_name).is_at_most(255) }

    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end

  describe ".active" do
    it "returns users that have not been deactivated" do
      active_user = create(:user, :active)
      deactivated_user = create(:user, :deactivated)

      results = User.active

      expect(results).to include(active_user)
      expect(results).not_to include(deactivated_user)
    end
  end

  describe ".deactive" do
    it "returns users that have been deactivated" do
      deactivated_user = create(:user, :deactivated)
      active_user = create(:user, :active)

      results = User.deactive

      expect(results).to include(deactivated_user)
      expect(results).not_to include(active_user)
    end
  end

  describe ".ordered" do
    it "orders users by last name and then by first name" do
      second_user = create(:user, first_name: "John", last_name: "Doe")
      third_user = create(:user, first_name: "Sally", last_name: "Smith")
      first_user = create(:user, first_name: "Jane", last_name: "Doe")

      results = User.ordered

      expect(results).to eq([first_user, second_user, third_user])
    end
  end

  describe "#active?" do
    it "returns true if user has not been deactivated" do
      active_user = build(:user, :active)

      expect(active_user.active?).to be_truthy
    end

    it "returns false if user has been deactivated" do
      deactivated_user = build(:user, :deactivated)

      expect(deactivated_user.active?).to be_falsey
    end
  end

  describe "#deactive?" do
    it "returns true if user has been deactivated" do
      deactivated_user = build(:user, :deactivated)

      expect(deactivated_user.deactive?).to be_truthy
    end

    it "returns false if user has not been deactivated" do
      active_user = build(:user, :active)

      expect(active_user.deactive?).to be_falsey
    end
  end

  describe "#full_name" do
    it "returns the first and last names joined by a space" do
      user = build(:user, first_name: "John", last_name: "Doe")

      expect(user.full_name).to eq("John Doe")
    end
  end
end

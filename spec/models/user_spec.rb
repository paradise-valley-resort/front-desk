require "rails_helper"

describe User do
  describe "validation" do
    it { should validate_length_of(:first_name).is_at_most(255) }
    it { should validate_length_of(:last_name).is_at_most(255) }

    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
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

  describe "#full_name" do
    it "returns the first and last names joined by a space" do
      user = build(:user, first_name: "John", last_name: "Doe")

      expect(user.full_name).to eq("John Doe")
    end
  end
end

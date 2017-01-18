require "rails_helper"

describe Member do
  describe "validation" do
    subject { build(:member) }

    it { should allow_values("", "foo@example.com").for(:email) }

    it { should validate_length_of(:address_1).is_at_most(255) }
    it { should validate_length_of(:address_2).is_at_most(255) }
    it { should validate_length_of(:city).is_at_most(255) }
    it { should validate_length_of(:email).is_at_most(255) }
    it { should validate_length_of(:first_name).is_at_most(255) }
    it { should validate_length_of(:last_name).is_at_most(255) }
    it { should validate_length_of(:membership_id).is_at_most(255) }
    it { should validate_length_of(:phone).is_at_most(255) }
    it { should validate_length_of(:state).is_at_most(255) }
    it { should validate_length_of(:zip_code).is_at_most(255) }

    it { should validate_presence_of(:address_1) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:membership_id) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip_code) }

    it { should validate_uniqueness_of(:membership_id) }

    it { should_not allow_values("fooexample.com", "foo@@example.com").for(:email) }
  end

  describe ".ordered" do
    it "orders members by last name and then by first name" do
      second_member = create(:member, first_name: "John", last_name: "Doe")
      third_member = create(:member, first_name: "Sally", last_name: "Smith")
      first_member = create(:member, first_name: "Jane", last_name: "Doe")

      results = Member.ordered

      expect(results).to eq([first_member, second_member, third_member])
    end
  end

  describe "#full_name" do
    it "returns the first and last names joined by a space" do
      member = build(:member, first_name: "John", last_name: "Doe")

      expect(member.full_name).to eq("John Doe")
    end
  end
end

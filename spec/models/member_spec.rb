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
end

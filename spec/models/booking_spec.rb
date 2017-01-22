require "rails_helper"

describe Booking do
  describe "associations" do
    it { should belong_to(:rental) }
  end

  describe "callbacks" do
    context "when saved" do
      it "should have 3PM starts at time" do
        booking = build(:booking, starts_at: Time.zone.now)

        booking.run_callbacks :save

        expect(booking.starts_at.strftime("%I:%M %p")).to eq("03:00 PM")
      end

      it "should have 11AM ends at time" do
        booking = build(:booking, ends_at: Time.zone.now)

        booking.run_callbacks :save

        expect(booking.ends_at.strftime("%I:%M %p")).to eq("11:00 AM")
      end
    end
  end

  describe "validations" do
    it { should allow_values("foo@example.com").for(:guest_email) }

    it { should validate_length_of(:guest_email).is_at_most(255) }
    it { should validate_length_of(:guest_name).is_at_most(255) }
    it { should validate_length_of(:guest_membership_id).is_at_most(255) }

    it { should validate_presence_of(:ends_at) }
    it { should validate_presence_of(:guest_email) }
    it { should validate_presence_of(:guest_name) }
    it { should validate_presence_of(:rental) }
    it { should validate_presence_of(:starts_at) }

    it { should_not allow_values("fooexample.com", "foo@@example.com").for(:guest_email) }
  end
end

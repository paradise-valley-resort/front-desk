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
    it { should validate_presence_of(:ends_at) }
    it { should validate_presence_of(:rental) }
    it { should validate_presence_of(:starts_at) }
  end
end

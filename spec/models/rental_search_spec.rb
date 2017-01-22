require "rails_helper"

describe RentalSearch do
  describe "validation" do
    it { should validate_presence_of(:ends_at) }
    it { should validate_presence_of(:starts_at) }

    it "validates starts at cannot be after ends at and vice versa" do
      search = RentalSearch.new(
        starts_at: 5.days.from_now.to_s,
        ends_at: 1.day.from_now.to_s
      )
      search.validate

      expect(search.errors.full_messages).to(
        include("Check In can't be after Check Out")
      )
      expect(search.errors.full_messages).to(
        include("Check Out can't be before Check In")
      )
    end

    it "validates ends at cannot be in the past" do
      search = RentalSearch.new(ends_at: 1.day.ago.to_s)

      search.validate

      expect(search.errors.full_messages).to(
        include("Check Out can't be in the past")
      )
    end

    it "validates starts at cannot be in the past" do
      search = RentalSearch.new(starts_at: 1.day.ago.to_s)

      search.validate

      expect(search.errors.full_messages).to(
        include("Check In can't be in the past")
      )
    end
  end

  describe "#results" do
    context "with invalid attributes" do
      it "triggers Rental.none" do
        search = RentalSearch.new

        expect(Rental).to receive(:none)

        search.results
      end
    end

    context "with valid attributes" do
      it "triggers Rental.available_between" do
        search = RentalSearch.new(
          starts_at: 1.day.from_now.to_s,
          ends_at: 5.days.from_now.to_s
        )

        expect(Rental).to receive(:available_between)

        search.results
      end
    end
  end
end

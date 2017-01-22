require "rails_helper"

describe Rental do
  describe "associations" do
    it { should have_many(:bookings).dependent(:destroy) }
  end

  describe "validations" do
    it { should validate_length_of(:name).is_at_most(255) }

    it { should validate_presence_of(:name) }
  end

  describe ".active" do
    it "returns rentals that have not been deactivated" do
      active_rental = create(:rental, :active)
      deactivated_rental = create(:rental, :deactivated)

      results = Rental.active

      expect(results).to include(active_rental)
      expect(results).not_to include(deactivated_rental)
    end
  end


  describe ".available_between" do
    context "deactivated rentals" do
      it "does not return deactivated rentals" do
        from = 1.day.from_now.change(hour: 15)
        to = 3.days.from_now.change(hour: 11)
        deactivated_rental = create(:rental, :deactivated)

        results = Rental.available_between(from, to)

        expect(results).not_to include(deactivated_rental)
      end
    end

    context "active rentals" do
      it "returns rentals without any bookings" do
        from = 1.day.from_now.change(hour: 15)
        to = 3.days.from_now.change(hour: 11)
        rental = create(:rental, :active)

        results = Rental.available_between(from, to)

        expect(results).to include(rental)
      end

      it "returns rentals without bookings between requested time range" do
        from = 5.days.from_now.change(hour: 15)
        to = 10.days.from_now.change(hour: 11)
        booking = create(
          :booking,
          starts_at: 1.day.from_now.change(hour: 15),
          ends_at: 3.days.from_now.change(hour: 11)
        )

        results = Rental.available_between(from, to)

        expect(results).to include(booking.rental)
      end

      it "does not return rentals with bookings between requested time range" do
        from = 1.day.from_now.change(hour: 15)
        to = 10.days.from_now.change(hour: 11)
        booking = create(
          :booking,
          starts_at: 3.days.from_now.change(hour: 15),
          ends_at: 5.days.from_now.change(hour: 11)
        )

        results = Rental.available_between(from, to)

        expect(results).not_to include(booking.rental)
      end

      it "does not return rentals with bookings overlapping requested from time" do
        from = 5.days.from_now.change(hour: 15)
        to = 10.days.from_now.change(hour: 11)
        booking = create(
          :booking,
          starts_at: 4.days.from_now.change(hour: 15),
          ends_at: 6.days.from_now.change(hour: 11)
        )

        results = Rental.available_between(from, to)

        expect(results).not_to include(booking.rental)
      end

      it "does not return rentals with bookings overlapping requested to time" do
        from = 1.day.from_now.change(hour: 15)
        to = 5.days.from_now.change(hour: 11)
        booking = create(
          :booking,
          starts_at: 4.days.from_now.change(hour: 15),
          ends_at: 6.days.from_now.change(hour: 11)
        )

        results = Rental.available_between(from, to)

        expect(results).not_to include(booking.rental)
      end

      it "does not return rentals with bookings starting on requested from time" do
        from = 1.day.from_now.change(hour: 15)
        to = 5.days.from_now.change(hour: 11)
        booking = create(
          :booking,
          starts_at: from,
          ends_at: 3.days.from_now.change(hour: 11)
        )

        results = Rental.available_between(from, to)

        expect(results).not_to include(booking.rental)
      end

      it "does not return rentals with bookings ending on requested to time" do
        from = 1.day.from_now.change(hour: 15)
        to = 7.days.from_now.change(hour: 11)
        booking = create(
          :booking,
          starts_at: 1.day.from_now.change(hour: 15),
          ends_at: to
        )

        results = Rental.available_between(from, to)

        expect(results).not_to include(booking.rental)
      end

      it "does not return rentals with bookings starting and ending on requested time range" do
        from = 1.day.from_now.change(hour: 15)
        to = 7.days.from_now.change(hour: 11)
        booking = create(
          :booking,
          starts_at: from,
          ends_at: to
        )

        results = Rental.available_between(from, to)

        expect(results).not_to include(booking.rental)
      end
    end
  end

  describe ".deactive" do
    it "returns rentals that have been deactivated" do
      deactivated_rental = create(:rental, :deactivated)
      active_rental = create(:rental, :active)

      results = Rental.deactive

      expect(results).to include(deactivated_rental)
      expect(results).not_to include(active_rental)
    end
  end

  describe ".ordered" do
    it "orders rentals by name" do
      second_rental = create(:rental, name: "Bravo")
      third_rental = create(:rental, name: "Charlie")
      first_rental = create(:rental, name: "Alpha")

      results = Rental.ordered

      expect(results).to eq([first_rental, second_rental, third_rental])
    end
  end

  describe "#active?" do
    it "returns true if rental has not been deactivated" do
      active_rental = build(:rental, :active)

      expect(active_rental.active?).to be_truthy
    end

    it "returns false if rental has been deactivated" do
      deactivated_rental = build(:rental, :deactivated)

      expect(deactivated_rental.active?).to be_falsey
    end
  end

  describe "#deactive?" do
    it "returns true if rental has been deactivated" do
      deactivated_rental = build(:rental, :deactivated)

      expect(deactivated_rental.deactive?).to be_truthy
    end

    it "returns false if rental has not been deactivated" do
      active_rental = build(:rental, :active)

      expect(active_rental.deactive?).to be_falsey
    end
  end
end

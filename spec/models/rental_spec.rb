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

require "rails_helper"

describe Rental do
  describe "validation" do
    it { should validate_length_of(:name).is_at_most(255) }

    it { should validate_presence_of(:name) }
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
end

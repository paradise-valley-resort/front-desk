require "rails_helper"

describe Rental do
  describe "validation" do
    it { should validate_length_of(:name).is_at_most(255) }

    it { should validate_presence_of(:name) }
  end
end

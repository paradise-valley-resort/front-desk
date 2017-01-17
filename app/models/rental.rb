class Rental < ApplicationRecord
  validates :name, length: { maximum: 255 }, presence: true

  def self.ordered
    order(:name)
  end
end

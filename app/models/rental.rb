class Rental < ApplicationRecord
  validates :name, length: { maximum: 255 }, presence: true
end

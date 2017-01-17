class Rental < ApplicationRecord
  validates :name, length: { maximum: 255 }, presence: true

  def self.ordered
    order(:name)
  end

  def active?
    deactivated_at.blank?
  end
end

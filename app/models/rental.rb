class Rental < ApplicationRecord
  has_many :bookings, dependent: :destroy

  validates :name, length: { maximum: 255 }, presence: true

  def self.active
    where(deactivated_at: nil)
  end

  def self.deactive
    where.not(deactivated_at: nil)
  end

  def self.ordered
    order(:name)
  end

  def active?
    deactivated_at.blank?
  end

  def deactive?
    deactivated_at.present?
  end
end

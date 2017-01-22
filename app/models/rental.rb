class Rental < ApplicationRecord
  has_many :bookings, dependent: :destroy

  validates :name, length: { maximum: 255 }, presence: true

  def self.active
    where(deactivated_at: nil)
  end

  def self.available_between(from, to)
    time_range = from..to

    left_outer_joins(:bookings).
      active.
      where.not(bookings: { starts_at: time_range }).
      where.not(bookings: { ends_at: time_range }).
      or(
        left_outer_joins(:bookings).
          active.
          where(bookings: { id: nil })
      ).
      distinct
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

  def available_between?(from, to)
    if self.class.available_between(from, to).include?(self)
      true
    else
      false
    end
  end

  def deactive?
    deactivated_at.present?
  end
end

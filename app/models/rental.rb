class Rental < ApplicationRecord
  has_many :bookings, dependent: :destroy

  validates :name, length: { maximum: 255 }, presence: true

  def self.active
    where(deactivated_at: nil)
  end

  def self.available_between(from, to)
    sql_conditions = <<-SQL.squish
      rentals.deactivated_at IS NULL
      AND (
        bookings.id IS NULL
        OR bookings.status IN (0, 2, 4)
        OR (
          rentals.id NOT IN (
            SELECT rental_id
            FROM bookings
            WHERE (
              status IN (1, 3)
              AND starts_at BETWEEN :from AND :to
              OR ends_at BETWEEN :from AND :to
            )
          )
        )
      )
    SQL

    left_outer_joins(:bookings).
      where(sql_conditions, from: from, to: to).
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
    overlapping_bookings = bookings.where(
      status: [1, 3],
      starts_at: from..to,
      ends_at: from..to
    )
    active? && overlapping_bookings.size < 1
  end

  def deactive?
    deactivated_at.present?
  end
end

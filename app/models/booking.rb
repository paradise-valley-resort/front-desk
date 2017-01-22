class Booking < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[^@]+@[^@]+\z/.freeze

  belongs_to :rental

  before_save :set_ends_at_time
  before_save :set_starts_at_time

  validates :ends_at, presence: true
  validates :guest_email,
            format: { with: VALID_EMAIL_REGEX },
            length: { maximum: 255 },
            presence: true
  validates :guest_membership_id, length: { maximum: 255 }
  validates :guest_name,
            length: { maximum: 255 },
            presence: true
  validates :rental, presence: true
  validates :starts_at, presence: true

  delegate :name, to: :rental, prefix: true

  private

  def set_ends_at_time
    self.ends_at = ends_at.change(hour: 11) unless ends_at.blank?
  end

  def set_starts_at_time
    self.starts_at = starts_at.change(hour: 15) unless starts_at.blank?
  end
end

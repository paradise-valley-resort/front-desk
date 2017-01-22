class Booking < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[^@]+@[^@]+\z/.freeze
  enum status: { pending: 0, approved: 1, rejected: 2 }

  belongs_to :rental

  before_create :generate_request_id
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

  def self.ordered
    order(created_at: :desc)
  end

  private

  def generate_request_id
    begin
      req_id = "PVR#{Time.zone.today.year}#{Time.zone.today.month}#{Time.zone.today.day}#{Array.new(4){rand(9)}.join}"
      self.request_id = req_id
    end while self.class.exists?(request_id:  req_id)
  end

  def set_ends_at_time
    self.ends_at = ends_at.change(hour: 11) unless ends_at.blank?
  end

  def set_starts_at_time
    self.starts_at = starts_at.change(hour: 15) unless starts_at.blank?
  end
end

class Booking < ApplicationRecord
  CALENDAR_HEX_COLORS = {
    pending: "#777",
    approved: "#337ab7",
    rejected: "#d9534f",
    paid: "#5cb85c",
    cancelled: "#d9534f"
  }
  VALID_EMAIL_REGEX = /\A[^@]+@[^@]+\z/.freeze
  enum status: { pending: 0, approved: 1, rejected: 2, paid: 3, cancelled: 4 }

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

  def self.between(start_date, end_date)
    date_range = start_date..end_date
    where(starts_at: date_range).
      where(ends_at: date_range)
  end

  def self.not_cancelled
    where.not(status: :cancelled)
  end

  def self.not_rejected
    where.not(status: :rejected)
  end

  def self.ordered
    order(created_at: :desc)
  end

  def as_json(options = {})
    {
      id: id,
      title: calendar_title,
      start: calendar_start_date,
      end: calendar_end_date,
      color: calendar_color_code,
      status: status
    }
  end

  private

  def calendar_color_code
    CALENDAR_HEX_COLORS.fetch(status.to_sym)
  end

  def calendar_end_date
    (ends_at + 1.day).rfc822
  end

  def calendar_start_date
    starts_at.rfc822
  end

  def calendar_title
    "#{rental_name} - #{guest_name} (#{status.capitalize})"
  end

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

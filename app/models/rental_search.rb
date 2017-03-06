class RentalSearch
  extend ActiveModel::Callbacks
  extend ActiveModel::Translation
  include ActiveModel::Model

  attr_accessor :starts_at, :ends_at

  define_model_callbacks :initialize, only: :after

  after_initialize :set_starts_at_time
  after_initialize :set_ends_at_time

  validate :ends_at_cannot_be_before_starts_at
  validate :ends_at_cannot_be_in_the_past
  validate :starts_at_cannot_be_after_ends_at
  validate :starts_at_cannot_be_in_the_past
  validates :ends_at, presence: true
  validates :starts_at, presence: true

  def initialize(params = {})
    super(params)
    run_callbacks :initialize
  end

  def results
    if starts_at.blank? || ends_at.blank?
      Rental.none
    else
      Rental.available_between(
        starts_at,
        ends_at
      )
    end
  end

  private

  def ends_at_cannot_be_in_the_past
    if ends_at.present? && ends_at < Time.zone.now.beginning_of_day
      errors.add(:ends_at, "can't be in the past")
    end
  end

  def ends_at_cannot_be_before_starts_at
    if ends_at.present? && starts_at.present? && ends_at < starts_at
      errors.add(:ends_at, "can't be before Check In")
    end
  end

  def set_starts_at_time
    self.starts_at = Time.zone.parse(starts_at).change(hour: 15) if starts_at.present?
  end

  def set_ends_at_time
    self.ends_at = Time.zone.parse(ends_at).change(hour: 11) if ends_at.present?
  end

  def starts_at_cannot_be_in_the_past
    if starts_at.present? && starts_at < Time.zone.now.beginning_of_day
      errors.add(:starts_at, "can't be in the past")
    end
  end

  def starts_at_cannot_be_after_ends_at
    if starts_at.present? && ends_at.present? && starts_at > ends_at
      errors.add(:starts_at, "can't be after Check Out")
    end
  end
end

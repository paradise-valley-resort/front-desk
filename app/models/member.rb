class Member < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[^@]+@[^@]+\z/.freeze

  validates :address_1, length: { maximum: 255 }, presence: true
  validates :address_2, length: { maximum: 255 }
  validates :city, length: { maximum: 255 }, presence: true
  validates :email,
            format: { with: VALID_EMAIL_REGEX },
            length: { maximum: 255 },
            allow_blank: true
  validates :first_name, length: { maximum: 255 }, presence: true
  validates :last_name, length: { maximum: 255 }, presence: true
  validates :membership_id,
            length: { maximum: 255 },
            presence: true,
            uniqueness: true
  validates :phone, length: { maximum: 255 }
  validates :state, length: { maximum: 255 }, presence: true
  validates :zip_code, length: { maximum: 255 }, presence: true

  def self.active
    where(deactivated_at: nil)
  end

  def self.deactive
    where.not(deactivated_at: nil)
  end

  def self.ordered
    order(:last_name, :first_name)
  end

  def active?
    deactivated_at.blank?
  end

  def deactive?
    deactivated_at.present?
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end

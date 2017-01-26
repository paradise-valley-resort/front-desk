class User < ApplicationRecord
  devise :database_authenticatable, :recoverable,
    :rememberable, :trackable, :validatable

  validates :first_name, length: { maximum: 255 }, presence: true
  validates :last_name, length: { maximum: 255 }, presence: true

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

  def active_for_authentication?
    super && active?
  end

  def deactive?
    deactivated_at.present?
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def inactive_message
    active? ? super : :deactivated
  end
end

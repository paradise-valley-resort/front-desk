class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, length: { maximum: 255 }, presence: true
  validates :last_name, length: { maximum: 255 }, presence: true

  def self.ordered
    order(:last_name, :first_name)
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end

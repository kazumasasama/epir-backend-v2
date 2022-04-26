class User < ApplicationRecord

  has_secure_password
  
  validates :email, presence: true, uniqueness: true

  has_many :events
  has_many :event_menus
  has_many :menus, through: :event_menus
end

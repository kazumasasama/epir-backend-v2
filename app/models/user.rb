class User < ApplicationRecord

  has_secure_password
  
  validates :email, presence: true, uniqueness: true

  has_many :events
  has_many :event_menus
  has_many :menus, through: :event_menus

  geocoded_by :address, latitude: :lat, longitude: :lon
  after_validation :geocode
end

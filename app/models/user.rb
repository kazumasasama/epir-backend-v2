class User < ApplicationRecord
  has_many :events
  has_many :event_menus
  has_many :menus, through: :event_menus
end

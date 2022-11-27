class Menu < ApplicationRecord

  validates :title, presence: true
  validates :category_id, presence: true
  
  has_many :event_menus
  has_many :events, through: :event_menus
end

class Menu < ApplicationRecord

  validates :title, presence: true
  
  has_many :event_menus
  has_many :events, through: :event_menus
  belongs_to :category
end

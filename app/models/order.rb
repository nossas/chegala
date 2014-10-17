class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_items
  has_many :tickets, through: :order_items
  has_many :events, through: :tickets
  validates :user, presence: true
end

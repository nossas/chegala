class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :ticket
  validates :order, :ticket, presence: true
end

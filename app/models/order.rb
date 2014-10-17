class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_items
  has_many :tickets, through: :order_items
  has_many :events, through: :tickets
  validates :user, presence: true

  accepts_nested_attributes_for :order_items

  after_create do
    self.events.each do |event|
      AddToMailchimpSegmentWorker.perform_async(event.mailchimp_segment_uid, self.user.mailchimp_uid)
    end
  end
end

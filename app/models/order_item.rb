class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :ticket
  has_one :event, through: :ticket
  has_one :user, through: :order
  validates :order, :ticket, presence: true

  after_create do
    AddToMailchimpSegmentWorker.perform_async(self.event.mailchimp_segment_uid, self.user.mailchimp_uid)
  end
end

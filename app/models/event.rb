class Event < ActiveRecord::Base
  belongs_to :user
  validates :user, :title, presence: true

  after_create do
    CreateMailchimpSegmentWorker.perform_async(
      "[Organizador] #{self.user.name}",
      self.user.class.name,
      self.user_id,
      "mailchimp_segment_uid"
    )
  end

  after_create do
    CreateMailchimpSegmentWorker.perform_async(
      "[Experiência] #{self.title}",
      self.class.name,
      self.id,
      "mailchimp_segment_uid"
    )
  end

  after_create do
    CreateMailchimpSegmentWorker.perform_async(
      "[Lista Amiga] #{self.title}",
      self.class.name,
      self.id,
      "mailchimp_vip_segment_uid"
    )
  end
end

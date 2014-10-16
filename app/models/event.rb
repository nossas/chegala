class Event < ActiveRecord::Base
  belongs_to :user
  validates :user, :title, presence: true

  after_create do
    CreateMailchimpSegmentWorker.perform_async(
      "[Organizador] #{self.user.name}",
      self.user.class.name,
      self.user_id
    )
  end

  after_create do
    CreateMailchimpSegmentWorker.perform_async(
      "[Experiência] #{self.title}",
      self.class.name,
      self.id
    )
  end
end

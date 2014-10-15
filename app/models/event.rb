class Event < ActiveRecord::Base
  belongs_to :user
  validates :user, :title, presence: true
  after_create { self.user.delay.create_mailchimp_segment }
  after_create { self.delay.create_mailchimp_segment }

  def create_mailchimp_segment
    segment = Gibbon::API.lists.segment_add(
      id: ENV['MAILCHIMP_LIST_ID'],
      opts: {
        type: "static",
        name: "[Experiência] #{self.title}"
      }
    )

    self.update_attribute :mailchimp_segment_uid, segment["id"]
  end
end

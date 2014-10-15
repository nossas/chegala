class Event < ActiveRecord::Base
  belongs_to :user
  after_create { self.user.delay.create_mailchimp_segment }
end

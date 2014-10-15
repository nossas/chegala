class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_create { UserWorker.perform_async(self.id) }

  validates :first_name, :last_name, presence: true

  def name
    "#{self.first_name} #{self.last_name}"
  end

  def create_mailchimp_segment
    segment = Gibbon::API.lists.segment_add(
      id: ENV['MAILCHIMP_LIST_ID'],
      opts: {
        type: "static",
        name: "[Organizador] #{self.name}"
      }
    )

    self.update_attribute :mailchimp_segment_uid, segment["id"].to_s
  end
end

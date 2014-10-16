class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_create { self.delay.add_to_mailchimp_list }

  validates :first_name, :last_name, presence: true

  def name
    "#{self.first_name} #{self.last_name}"
  end

  def add_to_mailchimp_list
    begin
      subscription = Gibbon::API.lists.subscribe(
        id: ENV['MAILCHIMP_LIST_ID'],
        email: { email: self.email },
        merge_vars: {
          FNAME: self.first_name,
          LNAME: self.last_name
        },
        double_optin: false,
        update_existing: true
      )
      self.update_column :mailchimp_uid, subscription["euid"]
    rescue Exception => e
      Appsignal.add_exception e
      Rails.logger.error e
    end
  end

  def create_mailchimp_segment
    segment = Gibbon::API.lists.segment_add(
      id: ENV['MAILCHIMP_LIST_ID'],
      opts: {
        type: "static",
        name: "[Organizador] #{self.name}"
      }
    )

    self.update_attribute :mailchimp_segment_uid, segment["id"]
  end
end

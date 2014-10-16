class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_create { SubscribeToMailchimpListWorker.perform_async(self.id) }

  validates :first_name, :last_name, presence: true

  def name
    "#{self.first_name} #{self.last_name}"
  end
end

class UserWorker
  include Sidekiq::Worker

  def perform user_id
    user = User.find(user_id)
    # add user to Mailchip list
  end
end

class SubscribeToMailchimpListWorker
  include Sidekiq::Worker

  def perform user_id, mailchimp_uid_column
    user = User.find(user_id)

    subscription = Gibbon::API.lists.subscribe(
      id: ENV['MAILCHIMP_LIST_ID'],
      email: { email: user.email },
      merge_vars: {
        FNAME: user.first_name,
        LNAME: user.last_name
      },
      double_optin: false,
      update_existing: true
    )
    user.update_attribute mailchimp_uid_column, subscription["euid"]
  end
end

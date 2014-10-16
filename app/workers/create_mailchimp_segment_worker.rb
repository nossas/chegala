class CreateMailchimpSegmentWorker
  include Sidekiq::Worker

  def perform segment_name, resource_name, resource_id, resource_mailchimp_uid_column
    segment = Gibbon::API.lists.segment_add(
      id: ENV['MAILCHIMP_LIST_ID'],
      opts: {
        type: "static",
        name: segment_name
      }
    )

    resource = eval(resource_name).find(resource_id)
    resource.update_attribute resource_mailchimp_uid_column, segment["id"]
  end
end

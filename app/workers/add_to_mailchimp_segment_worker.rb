class AddToMailchimpSegmentWorker
  include Sidekiq::Worker

  def perform segment_id, euid
    Gibbon::API.lists.static_segment_members_add(
      id: ENV['MAILCHIMP_LIST_ID'],
      seg_id: segment_id,
      batch: [{ euid: euid }]
    )
  end
end

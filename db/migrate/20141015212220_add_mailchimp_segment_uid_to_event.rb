class AddMailchimpSegmentUidToEvent < ActiveRecord::Migration
  def change
    add_column :events, :mailchimp_segment_uid, :string
  end
end

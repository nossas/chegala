class AddMailchimpVipSegmentUidToEvent < ActiveRecord::Migration
  def change
    add_column :events, :mailchimp_vip_segment_uid, :string
  end
end

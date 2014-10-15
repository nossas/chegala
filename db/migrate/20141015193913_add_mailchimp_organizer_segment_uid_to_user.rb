class AddMailchimpOrganizerSegmentUidToUser < ActiveRecord::Migration
  def change
    add_column :users, :mailchimp_organizer_segment_uid, :string
  end
end

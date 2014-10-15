class AlterColumnMailchimpOrganizerSegmentUid < ActiveRecord::Migration
  def change
    rename_column :users, :mailchimp_organizer_segment_uid, :mailchimp_segment_uid
  end
end

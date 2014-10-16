class AddMailchimpUidToUser < ActiveRecord::Migration
  def change
    add_column :users, :mailchimp_uid, :string
  end
end

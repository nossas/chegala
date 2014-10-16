require 'rails_helper'

RSpec.describe SubscribeToMailchimpListWorker, :type => :worker do
  describe '#perform' do
    let(:user) { User.make! }
    let(:mailchimp_uid_column) { "mailchimp_uid" }

    it "should update user's Mailchimp uid" do
      expect {
        SubscribeToMailchimpListWorker.new.perform user.id, mailchimp_uid_column
      }.to change{ user.reload.mailchimp_uid }
    end
  end
end

require 'rails_helper'

RSpec.describe SubscribeToMailchimpListWorker, :type => :worker do
  describe '#perform' do
    let(:user) { User.make! }

    it "should update user's Mailchimp uid" do
      expect { SubscribeToMailchimpListWorker.new.perform user.id }.to change{ user.reload.mailchimp_uid }
    end
  end
end

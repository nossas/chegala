require 'rails_helper'

RSpec.describe AddToMailchimpSegmentWorker, :type => :worker do
  describe '#perform' do
    let(:segment_id){ "segment_id" }
    let(:euid){ "euid" }

    it "should add it to the Mailchimp segment" do
      stub_request(:post, "https://api.mailchimp.com/2.0/lists/static-segment-members-add").
         with(:body => "{\"apikey\":\"MAILCHIMP_API_KEY\",\"id\":\"MAILCHIMP_LIST_ID\",\"seg_id\":\"#{segment_id}\",\"batch\":[{\"euid\":\"#{euid}\"}]}").
         to_return(:status => 200, :body => "", :headers => {})

      AddToMailchimpSegmentWorker.new.perform segment_id, euid

      assert_requested(
        :post,
        "https://api.mailchimp.com/2.0/lists/static-segment-members-add",
         :body => "{\"apikey\":\"MAILCHIMP_API_KEY\",\"id\":\"MAILCHIMP_LIST_ID\",\"seg_id\":\"#{segment_id}\",\"batch\":[{\"euid\":\"#{euid}\"}]}"
      )
    end
  end
end

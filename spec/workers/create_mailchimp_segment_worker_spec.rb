require 'rails_helper'

RSpec.describe CreateMailchimpSegmentWorker, :type => :worker do
  describe '#perform' do
    let(:segment_name)  { "Segment Name" }
    let(:event)         { Event.make! }
    let(:resource_name) { "Event" }
    let(:resource_id)   { event.id }

    before do
      stub_request(:post, "https://api.mailchimp.com/2.0/lists/segment-add").
        with(:body => "{\"apikey\":\"#{ENV['MAILCHIMP_API_KEY']}\",\"id\":\"#{ENV['MAILCHIMP_LIST_ID']}\",\"opts\":{\"type\":\"static\",\"name\":\"#{segment_name}\"}}").
        to_return(
          :status => 200,
          :body => File.open("#{Rails.root}/spec/support/fixtures/mailchimp/segment_add.json").read,
          :headers => {}
        )
    end

    it 'should create a Mailchimp segment' do
      CreateMailchimpSegmentWorker.new.perform segment_name, resource_name, resource_id

      assert_requested(
        :post,
        "https://api.mailchimp.com/2.0/lists/segment-add",
        :body => "{\"apikey\":\"#{ENV['MAILCHIMP_API_KEY']}\",\"id\":\"#{ENV['MAILCHIMP_LIST_ID']}\",\"opts\":{\"type\":\"static\",\"name\":\"#{segment_name}\"}}"
      )
    end

    it "should update resource's Mailchimp uid" do
      expect {
        CreateMailchimpSegmentWorker.new.perform segment_name, resource_name, resource_id
      }.to change{ event.reload.mailchimp_segment_uid }
    end
  end
end

require 'rails_helper'

RSpec.describe Event, :type => :model do
  it { should belong_to :user }
  it { should validate_presence_of :user }
  it { should validate_presence_of :title }

  describe "#create_mailchimp_segment" do
    subject { Event.make! }

    it "should update mailchimp_segment_uid" do
      stub_request(:post, "https://api.mailchimp.com/2.0/lists/segment-add").
         with(:body => "{\"apikey\":\"#{ENV['MAILCHIMP_API_KEY']}\",\"id\":\"#{ENV['MAILCHIMP_LIST_ID']}\",\"opts\":{\"type\":\"static\",\"name\":\"[Experiência] #{subject.title}\"}}").
         to_return(
          :status => 200,
          :body => File.open("#{Rails.root}/spec/support/fixtures/mailchimp/segment_add.json").read,
          :headers => {}
        )

      expect {
        subject.create_mailchimp_segment
      }.to change{ subject.mailchimp_segment_uid }
    end
  end
end

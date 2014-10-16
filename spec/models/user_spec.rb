require 'rails_helper'

RSpec.describe User, :type => :model do
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }

  describe "#after_create" do
    subject { User.make! }

    it "should update mailchimp_uid" do
      expect(subject.mailchimp_uid).to_not be_nil
    end
  end

  describe "#create_mailchimp_segment" do
    it "should update mailchimp_segment_uid" do
      stub_request(:post, "https://api.mailchimp.com/2.0/lists/segment-add").
        with(:body => "{\"apikey\":\"#{ENV['MAILCHIMP_API_KEY']}\",\"id\":\"#{ENV['MAILCHIMP_LIST_ID']}\",\"opts\":{\"type\":\"static\",\"name\":\"[Organizador] #{subject.name}\"}}").
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

  describe "#name" do
    it "should be the first_name followed by the last_name" do
      subject.first_name = "Lionel"
      subject.last_name = "Messi"
      expect(subject.name).to be_eql("Lionel Messi")
    end
  end
end

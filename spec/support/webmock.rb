RSpec.configure do |config|
  config.before(:each) do
    stub_request(:post, "https://api.mailchimp.com/2.0/lists/subscribe").
      to_return(
        :status => 200,
        :body => File.open("#{Rails.root}/spec/support/fixtures/mailchimp/subscribe.json").read,
        :headers => {}
      )
  end
end
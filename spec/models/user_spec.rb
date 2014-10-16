require 'rails_helper'

RSpec.describe User, :type => :model do
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }

  describe "#name" do
    it "should be the first_name followed by the last_name" do
      subject.first_name = "Lionel"
      subject.last_name = "Messi"
      expect(subject.name).to be_eql("Lionel Messi")
    end
  end
end

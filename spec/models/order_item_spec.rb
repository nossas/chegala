require 'rails_helper'

RSpec.describe OrderItem, :type => :model do
  it { should belong_to :order }
  it { should belong_to :ticket }
  it { should validate_presence_of :order }
  it { should validate_presence_of :ticket }
end

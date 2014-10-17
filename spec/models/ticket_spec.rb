require 'rails_helper'

RSpec.describe Ticket, :type => :model do
  it { should belong_to :event }
  it { should validate_presence_of :event }
end

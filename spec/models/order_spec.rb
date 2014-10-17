require 'rails_helper'

RSpec.describe Order, :type => :model do
  it { should belong_to :user }
  it { should have_many :order_items }
  it { should have_many :tickets }
  it { should have_many :events }
  it { should validate_presence_of :user }
end

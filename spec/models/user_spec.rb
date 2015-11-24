require 'rails_helper'

RSpec.describe User, type: :model do
  it "creates a user with username and password" do
    user = FactoryGirl.build(:user)
    expect(user.valid?).to be_truthy
  end
end

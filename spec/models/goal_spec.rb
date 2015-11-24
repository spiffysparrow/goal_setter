require 'rails_helper'

RSpec.describe Goal, type: :model do

  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:private) }
  end

  describe "associations" do
    it { should belong_to(:user) }
  end

  it "valid simple goal" do
    user = FactoryGirl.create(:user)
    goal = Goal.new(title: "walking", body: "will walk more", user_id: user.id, private: true)
    expect(goal.valid?).to be_truthy
  end

end

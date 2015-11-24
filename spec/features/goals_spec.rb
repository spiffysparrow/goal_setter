require 'spec_helper'
require 'rails_helper'
require_relative './helper_methods'

feature "index page" do
  before(:each) do
    visit goals_url
  end
  scenario "exisits" do
    expect(page).to have_content("Goals")
  end
  scenario "new goal button on index page" do
    expect(page).to have_button("New Goal")
  end

end

feature "new page" do

  feature "when not logged in" do
    scenario "can't visit new goals page" do
      visit new_goal_url
      expect(current_path).to eq(new_session_url)
    end
  end

  feature "when logged in" do
    before(:each) do
      sign_in
      visit new_goal_url
    end
    scenario "exisits" do
      expect(page).to have_content("New Goal")
    end
    scenario "create new goal" do
      fill_in "Title", with: "More Carrots"
      choose "Private"
      click_on "Create Goal"
      expect(current_path).not_to eq(new_goal_url)
      expect(page).to have_content("More Carrots")
    end
    scenario "no title" do
      choose "Private"
      click_on "Create Goal"
      expect(page).to have_content("Title can't be blank")
    end
    scenario "default private" do
      input("Private").to be_check
    end
  end

end

require 'spec_helper'
require 'rails_helper'
require_relative './helper_methods'


feature "The sign-up process" do
  scenario "the page exitst" do
    visit new_user_url
    expect(page).to have_content("Sign Up")
  end

  feature "signs up a user" do
    before(:each) do
      visit new_user_url
      fill_in 'Username', with: "fake_name"
      fill_in 'Password', with: "password"
      click_on 'Sign Up'
    end
    scenario "shows username after login" do
      expect(page).to have_content("fake_name")
    end
    scenario "redirects away from sign up page" do
      expect(page).not_to have_content("Sign Up")
      expect(current_path).not_to eq(new_user_url)
    end
  end

  feature "shows errors for incorrect sign up" do
    scenario "requires username" do
      visit new_user_url
      fill_in 'Password', with: "password"
      click_on 'Sign Up'
      expect(page).to have_content("Sign Up")
      expect(page).to have_content("Username can't be blank")
    end
    scenario "requires Username" do
      visit new_user_url
      fill_in 'Username', with: "fake_name"
      click_on 'Sign Up'
      expect(page).to have_content("Sign Up")
      expect(page).to have_content("Password is too short")
    end
  end
end


feature "The login process" do
  scenario "the page exisits" do
    visit new_session_url
    expect(page).to have_content("Log In")
  end
  feature "logs in user" do
    before(:each) do
      visit new_session_url
    end
    let!(:user) do
      User.create(username: "Bob", password: "password")
    end
    scenario "logs in user" do
      fill_in "Username", with: user.username
      fill_in "Password", with: user.password
      click_on "Log In"
      expect(page).to have_content(user.username)
    end
    scenario "missing password" do
      fill_in "Username", with: user.username
      click_on "Log In"
      expect(page).to have_content("Incorrect username or password")
    end
    scenario "incorrect password" do
      fill_in "Username", with: user.username
      fill_in "Password", with: "pawword"
      click_on "Log In"
      expect(page).to have_content("Incorrect username or password")
    end
    scenario "missing username" do
      fill_in "Password", with: user.password
      click_on "Log In"
      expect(page).to have_content("Incorrect username or password")
    end
  end

  feature "Log out" do
    before(:each) do
      sign_in
    end
    scenario  "log out button on show page" do
      expect(page).to have_button('Log Out')
    end
    scenario "redirects to log in page" do
      click_on "Log Out"
      expect(page).to have_content("Log In")
    end
  end

end

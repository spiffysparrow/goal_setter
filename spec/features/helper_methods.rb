
def sign_in
  visit new_user_url
  fill_in 'Username', with: "fake_name"
  fill_in 'Password', with: "password"
  click_on 'Sign Up'
end

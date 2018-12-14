require 'rails_helper'
RSpec.feature 'Successful Reset Password' do
  scenario 'valid user goes to reset password and gets sent link in email' do
    user = create(:user)
    visit '/users/password/new'
    fill_in 'user_email', with: user.email
    click_on 'Reset Password'
    email = ActionMailer::Base.deliveries.last
    expect(page).to have_current_path(new_user_session_path)
    expect(page.body).to include('how to reset')
    expect(email.to[0]).to eq(user.email)
    expect(email.body).to include('link to change your password')
  end
  scenario 'valid user goes to reset password link and resets password' do
    user = create(:user)
    new_password = 'password1234'
    visit '/users/password/new'
    fill_in 'user_email', with: user.email
    click_on 'Reset Password'
    email = ActionMailer::Base.deliveries.last
    expect(User.first.valid_password?(new_password)).to be_falsey
    reset_password_token = email.body.to_s.split('reset_password_token=')[1].split("\"")[0]
    visit "/users/password/edit?reset_password_token=#{reset_password_token}"
    fill_in 'user_password', with: new_password
    fill_in 'user_password_confirmation', with: new_password
    click_on 'Change my password'
    expect(User.first.valid_password?(new_password)).to be_truthy
  end
  scenario 'user logs in and then changes password' do
    user = create(:user)
    new_password = 'password1234'
    visit '/users/sign_in'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_on 'Log in'
    click_on 'Change your email and/or password'
    expect(User.first.valid_password?(new_password)).to be_falsey
    fill_in 'user_password', with: new_password
    fill_in 'user_password_confirmation', with: new_password
    fill_in 'user_current_password', with: user.password
    click_on 'Update'
    
    expect(User.first.valid_password?(new_password)).to be_truthy
    expect(page).to have_current_path(admin_user_index_path)
    
  end
  scenario 'user logs in and then changes email address' do
    user = create(:user)
    new_email = 'new_email@somewhere.net'
    visit '/users/sign_in'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_on 'Log in'
    click_on 'Change your email and/or password'
    expect(User.first.email).not_to eq(new_email)
    fill_in 'user_email', with: new_email
    fill_in 'user_current_password', with: user.password
    click_on 'Update'
    
    expect(User.first.email).to eq(new_email)
  end
end

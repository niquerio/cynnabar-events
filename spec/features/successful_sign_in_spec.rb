require 'rails_helper'
RSpec.feature 'Successful Sign in' do
  scenario 'admin user signs in' do
    admin = create(:admin_user)
    visit '/users/sign_in'
    fill_in 'user_email', with: admin.email
    fill_in 'user_password', with: admin.password
    click_on 'Log in'
    expect(page).to have_current_path(user_index_path)
  end
end

require 'rails_helper'
feature "Admin User Sees their events (so all events) #TBC" do
  include_context "when signed in through capybara"
  scenario "admin sees their events" do
    admin = create(:admin_user)
    event1 = create(:event_series, name: 'My Event', slug: 'my_event')
    event2 = create(:event_series, name: 'Other Event', slug: 'other_event')
    sign_in(admin)
    expect(page.body).to include('My Event')
    expect(page.body).to include('Other Event')
  end
end
    

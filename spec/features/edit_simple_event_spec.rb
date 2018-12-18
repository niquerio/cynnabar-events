require 'rails_helper'
feature "Admin can edit simple event" do
  include_context "when signed in through capybara"
  scenario "admin clicks on dashboard edit event link and updates an event when there are no pages" do
    admin = create(:admin_user)
    event = create(:event)
    sign_in(admin)
    click_on(event.name)
    expect(page).to have_current_path(edit_admin_event_path(event.id))
    fill_in 'event_name', with: 'Brand New Event 2'
		fill_in 'Gate', with: 'Gate is open!'
    click_on 'Update Event'
    expect(Event.first.name).to eq('Brand New Event 2')  
    expect(Event.first.pages.find_by(slug: 'gate').body).to eq('Gate is open!')  
    expect(page).to have_current_path(admin_user_index_path)
    expect(page.body).to include('Event successfully updated')
  end
  scenario "admin clicks on dashboard edit event link and updates an event when there are existing pages" do
    admin = create(:admin_user)
    event = create(:simple_event_full)
		schedule = event.page('schedule').body
    sign_in(admin)
    click_on(event.name)
    expect(page).to have_current_path(edit_admin_event_path(event.id))
    fill_in 'event_name', with: 'Brand New Event 2'
		fill_in 'Gate', with: 'Gate is open!'
    click_on 'Update Event'
    expect(Event.first.name).to eq('Brand New Event 2')  
    expect(Event.first.pages.find_by(slug: 'gate').body).to eq('Gate is open!')  
    expect(Event.first.page('schedule').body).to eq(schedule)  
    expect(page).to have_current_path(admin_user_index_path)
    expect(page.body).to include('Event successfully updated')
  end
end

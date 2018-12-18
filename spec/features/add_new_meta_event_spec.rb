require 'rails_helper'
feature "Create Meta Event" do
  include_context "when signed in through capybara"
  scenario "admin creates new meta event" do
    admin = create(:admin_user)
    sign_in(admin)
    click_on 'Create New Event Series'
    expect(page).to have_current_path(new_admin_event_series_path)
    fill_in 'meta_event_name', with: 'New Event'
    fill_in 'meta_event_slug', with: 'new_event'
    fill_in 'meta_event[events_attributes][0][name]', with: 'New Event 1' 
    fill_in 'meta_event[events_attributes][0][start_date]', with: '01-Dec-2018'
    fill_in 'meta_event[events_attributes][0][end_date]', with: '02-Dec-2018'
    click_on 'Create Event Series'
    expect(MetaEvent.first.name).to eq('New Event') 
    expect(MetaEvent.first.slug).to eq('new_event') 
    event = MetaEvent.first.events.first 
    expect(event.name).to eq('New Event 1')
    expect(event.start_date).to eq(DateTime.parse('01-Dec-2018 00:00:00-05:00'))
    expect(event.end_date).to eq(DateTime.parse('02-Dec-2018 23:59:59-05:00'))
  end
end

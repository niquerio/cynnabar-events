require 'rails_helper'
feature "Admin can edit simple event" do
  include_context "when signed in through capybara"
  def fill_in_form(hash)
    fill_in 'event_name', with: hash[:event_name] 
		fill_in 'Gate', with: hash[:gate_body]
    fill_in 'event[contacts_attributes][0][email]', with: hash[:contact_email]
    fill_in 'event[contacts_attributes][0][name]', with: hash[:contact_name]
    fill_in 'event[locations_attributes][0][name]', with: hash[:location_name]
    fill_in 'event[locations_attributes][0][address]', with: hash[:address]
    click_on 'Update Event'
  
  end
  def update_expectations(hash)
    expect(Event.first.name).to eq(@hash[:event_name])  
    expect(Event.first.page('gate').body).to eq(@hash[:gate_body])  
    contact = Event.first.contacts.first
    expect(contact.email).to eq(@hash[:contact_email])
    expect(contact.name).to eq(@hash[:contact_name])
		location = Event.first.locations.first
    expect(location.name).to eq(@hash[:location_name])
    expect(location.address).to eq(@hash[:address])
    expect(page).to have_current_path(admin_user_index_path)
    expect(page.body).to include('Event successfully updated')
  end
  before(:each) do
    @hash = { event_name: 'Event!!', gate_body: 'Gate is open!', 
      contact_email: 'someone@somewhere.com', contact_name: 'Someone', 
			location_name: 'Some Church Basement', address: '5555 Someplace Dr.; Ann Arbor, MI, 48105'
	    }
  end
  scenario "admin clicks on dashboard edit event link and updates an event when there are no pages" do
    admin = create(:admin_user)
    event = create(:event)
    sign_in(admin)
    click_on(event.name)
    expect(page).to have_current_path(edit_admin_event_path(event.id))
    fill_in_form(@hash)
    update_expectations(@hash)
  end
  scenario "admin clicks on dashboard edit event link and updates an event when there are existing pages" do
    admin = create(:admin_user)
    event = create(:simple_event_full)
		schedule = event.page('schedule').body

    sign_in(admin)
    click_on(event.name)
    expect(page).to have_current_path(edit_admin_event_path(event.id))
    fill_in_form(@hash)

    update_expectations(@hash)
    expect(Event.first.page('schedule').body).to eq(schedule)  
  end
end

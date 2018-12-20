require 'rails_helper'
require 'edit_event_presenter'
describe EditEventPresenter, 'initialize event' do
  context 'empty event' do
    before(:each) do
      @event = create(:event, name: '')
      @eep = EditEventPresenter.new(@event)
    end 
    it 'initializes with event' do
      expect(@eep.name).to eq('')
    end
    it 'returns empty facebook_event_link' do
      expect(@eep.facebook_event_link).to  be_nil
    end
    it 'has gate page' do
      expect(@eep.pages.map {|p| p.title == 'Gate' && p.slug == 'gate' && p.body.nil?}.any?).to be_truthy
    end
    it 'has schedule page' do
      expect(@eep.pages.map {|p| p.title == 'Schedule' && p.slug == 'schedule' && p.body.nil?}.any?).to be_truthy
    end
    it 'has food page' do
      expect(@eep.pages.map {|p| p.title == 'Food' && p.slug == 'food' && p.body.nil?}.any?).to be_truthy
    end
    it 'has description page' do
      expect(@eep.pages.map {|p| p.title == 'Description' && p.slug == 'description' && p.body.nil?}.any?).to be_truthy
    end
    it 'has empty event steward' do
      expect(@eep.contacts.size).to eq(1)
      steward = @eep.contacts.first
      expect(steward.job).to eq('Event Steward')
      expect(steward.email).to be_nil
      expect(steward.name).to be_nil
    end
    it 'has an empty location' do
      expect(@eep.locations.size).to eq(1)
      loc = @eep.locations.first
      expect(loc.name).to be_nil
      expect(loc.address).to be_nil
    end
  end
  context 'filled out event' do
    before(:each) do
      @event = create(:simple_event_full)
      @eep = EditEventPresenter.new(@event)
    end 
    it 'initializes with event' do
      expect(@eep.name).to eq(@event.name)
    end
    it 'returns empty facebook_event_link' do
      expect(@eep.facebook_event_link).to eq(@event.facebook_event_link) 
    end
    it 'has gate page' do
      expect(@eep.pages.include?(@event.page('gate'))).to be_truthy
    end
    it 'has schedule page' do
      expect(@eep.pages.include?(@event.page('schedule'))).to be_truthy
    end
    it 'has food page' do
      expect(@eep.pages.include?(@event.page('food'))).to be_truthy
    end
    it 'has description page' do
      expect(@eep.pages.include?(@event.page('description'))).to be_truthy
    end
    it 'has event steward' do
      expect(@eep.contacts.size).to eq(1)
      steward = @eep.contacts.first
      expect(steward.job).to eq(@event.contacts.first.job)
      expect(steward.email).to eq(@event.contacts.first.email)
      expect(steward.name).to eq(@event.contacts.first.name)
    end
    it 'has a location' do
      expect(@eep.locations.size).to eq(1)
      loc = @eep.locations.first
      expect(loc.name).to eq(@event.locations.first.name)
      expect(loc.address).to eq(@event.locations.first.address)
    end
  end
end

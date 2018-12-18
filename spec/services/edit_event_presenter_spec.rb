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
  end
end

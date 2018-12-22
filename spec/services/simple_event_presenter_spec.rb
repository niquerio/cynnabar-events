require 'rails_helper'
require 'simple_event_presenter'
describe SimpleEventPresenter, 'initialize event' do
  context 'empty event' do
    before(:each) do
      @event = create(:event, name: '')
      @sep = SimpleEventPresenter.new(@event)
    end 
    it 'initializes with event' do
      expect(@sep.name).to eq('')
    end
    it 'returns empty facebook_event_link' do
      expect(@sep.facebook_event_link).to  be_nil
    end
  end
  context 'filled out event' do
    before(:each) do
      @event = create(:simple_event_full)
      @sep = SimpleEventPresenter.new(@event)
    end 
    it 'initializes with event' do
      expect(@sep.name).to eq(@event.name)
    end
    it 'returns empty facebook_event_link' do
      expect(@sep.facebook_event_link).to eq(@event.facebook_event_link) 
    end
  end
end
describe SimpleEventPresenter, 'date' do
  it "returns TBD for empty start and end date" do
    event = create(:event)
    sep = SimpleEventPresenter.new(event)
    expect(sep.date).to eq('TBD') 
  end
  it "returns date in form of 'Saturday, December 19, 2018' for single day event" do
    event = create(:event, start_date: '2018-December-1', end_date: '2018-December-1')
    sep = SimpleEventPresenter.new(event)
    expect(sep.date).to eq('Saturday, December 1, 2018')
  end
  it "returns date in form of 'Saturday, December 1 - Sunday, December 2, 2018' for multi-day event in same year" do
    event = create(:event, start_date: '2018-December-1', end_date: '2018-December-2')
    sep = SimpleEventPresenter.new(event)
    expect(sep.date).to eq('Saturday, December 1 - Sunday, December 2, 2018')
  end
  it "returns date in form of 'Monday, December 31, 2018 - Tuesday, January 1, 2019' for multi-day event in differnet years" do
    event = create(:event, start_date: '2018-December-31', end_date: '2019-January-1')
    sep = SimpleEventPresenter.new(event)
    expect(sep.date).to eq('Monday, December 31, 2018 - Tuesday, January 1, 2019')
  end 
end

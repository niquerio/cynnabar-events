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
describe SimpleEventPresenter, 'pages' do
  it "returns pages in specific order" do
    event = create(:simple_event_full)
    sep = SimpleEventPresenter.new(event)
    expect(sep.pages.pluck(:slug)).to eq(["gate","schedule","food","info"])
  end 
  it "returns pages leaves out empty pages" do
    event = create(:simple_event_full)
    sep = SimpleEventPresenter.new(event)
    event.pages.find_by(slug: 'schedule').update(body: nil)
    event.pages.find_by(slug: 'info').update(body: nil)
    expect(sep.pages.pluck(:slug)).to eq(["gate","food"])
  end 
end

describe SimpleEventPresenter, 'description' do
  it "returns description page" do
    event = create(:simple_event_full)
    sep = SimpleEventPresenter.new(event)
    expect(sep.description).to eq(event.page('description').body)
  end 
  it "returns nil for no description page" do
    event = create(:event)
    sep = SimpleEventPresenter.new(event)
    expect(sep.description).to be_nil
  end
  it "returns nil for empty description page" do
    event = create(:simple_event_full)
    event.pages.find_by(slug: 'description').update(body: nil)
    sep = SimpleEventPresenter.new(event)
    expect(sep.description).to be_nil
  end
end
describe SimpleEventPresenter, 'location' do
  it "returns location page" do
    event = create(:event)
    location = create(:location, name: 'My Location', address: '5555 Division St., Ann Arbor, MI, 48105', event: event)
    sep = SimpleEventPresenter.new(event)
    expect(sep.location).to eq("#{location.name}, #{location.address}")
  end 
  it "returns TBD for no location" do
    event = create(:event)
    sep = SimpleEventPresenter.new(event)
    expect(sep.location).to eq('TBD')
  end
  it "returns TBD for empty location" do
    event = create(:event)
    location = create(:location, name: nil, address: nil, event: event)
    sep = SimpleEventPresenter.new(event)
    expect(sep.location).to eq('TBD')
  end
  it "returns only address for no location name, but has an address" do
    event = create(:event)
    location = create(:location, name: nil, address: '5555 Division St., Ann Arbor, MI, 48105', event: event)
    sep = SimpleEventPresenter.new(event)
    expect(sep.location).to eq(location.address)
  end
  it "returns only location name for only location name, but no address" do
    event = create(:event)
    location = create(:location, name: 'My Location', address: nil, event: event)
    sep = SimpleEventPresenter.new(event)
    expect(sep.location).to eq(location.name)
  end
end
describe SimpleEventPresenter, 'contact' do
  it "returns description page" do
    event = create(:simple_event_full)
    sep = SimpleEventPresenter.new(event)
    expect(sep.contact).to eq(event.contacts.first)
  end 
  it "returns nil for no contact" do
    event = create(:event)
    sep = SimpleEventPresenter.new(event)
    expect(sep.contact).to be_nil
  end
  it "returns nil for empty contact name" do
    event = create(:simple_event_full)
    event.contacts.first.update(name: '')
    sep = SimpleEventPresenter.new(event)
    expect(sep.contact).to be_nil
  end
  it "returns nil for empty contact email" do
    event = create(:simple_event_full)
    sep = SimpleEventPresenter.new(event)
    event.contacts.first.update(email: '')
    expect(sep.contact).to be_nil
  end
end

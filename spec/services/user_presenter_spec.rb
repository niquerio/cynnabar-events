require 'rails_helper'
require 'user_presenter'
describe UserPresenter, 'initialize' do
  it 'initializes with user' do
    user = create(:admin_user)
    up = UserPresenter.new(user)
    expect(up.email).to eq(user.email)
  end
end
describe UserPresenter, 'event_series' do
  it 'returns all events #TBC' do
    es1 = create(:event_series) 
    es2 = create(:event_series, name: 'Other Event', slug: 'other_event') 
    user = create(:admin_user)
    up = UserPresenter.new(user)
    expect(up.event_series.count).to eq(2)
    
  end
end

require 'rails_helper'

RSpec.describe Event, 'page(slug)' do
  it 'returns page for given slug' do
    event = create(:event)
    page = create(:page, event: event, slug: 'slug')
    expect(event.page('slug')).to eq(page)
  end

end

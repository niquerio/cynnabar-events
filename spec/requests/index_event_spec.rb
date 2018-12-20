require "rails_helper"
describe "Get /:slug" do
  it "shows event page for given slug" do
		event = create(:event)
    get "/#{event.slug}"
    expect(response).to have_http_status(200)
    expect(response.body).to include(event.name)
  end
end

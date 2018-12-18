class AddFacebookEventLinkToEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :facebook_event_link, :string
  end
end

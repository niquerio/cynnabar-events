FactoryBot.define do
  factory :location do
    event
    name { "MyString" }
    address { "MyString" }
    description { nil }
  end
  factory :contact do
    event
    name { "Alex Aardvark" }
    job { "floor waxer" }
    email { "alex@aardvark.net" }
  end
  factory :page do
    event 
    title { "MyString" }
    body { "MyText" }
    slug { "MyString" }
  end
  factory :event do
    meta_event 
    name { "My Event 1" }
    start_date { nil }
    end_date { nil }
  end
  factory :simple_event_full, parent: :event do
    name {"Simple Event Full"}
    start_date { "2018-12-11" }
    end_date { "2018-12-11" }
    after(:create) do |e|
      create(:page, body: 'Gate Gate Gate', title: 'Gate', slug: 'gate', event: e)
      create(:page, body: 'Schedule Schedule Schedule', title: 'Schedule', slug: 'schedule', event: e)
      create(:page, body: 'Food Food Food', title: 'Food', slug: 'food', event: e)
      create(:page, body: 'Desc Desc Desc', title: 'Description', slug: 'description', event: e)
      create(:page, body: 'Info Info Info', title: 'Info', slug: 'info', event: e)
      create(:contact, job: 'Event Steward', event: e)
      create(:location, name: 'The Usual Church Basement', address: '55555 Division St.; Ann Arbor, MI, 48104')
    end
  end
  factory :meta_event do
    slug { "my_event" }
    name { "My Event" }
  end

  factory :event_series, parent: :meta_event do
    after(:create) do |s|
      create(:event, meta_event: s)
    end
  end
  sequence :email do |n|
    "person#{n}@example.com"
  end
  factory :user, aliases: [:admin_user] do
    email {generate :email}
    password {Devise.friendly_token.first(8)}
  end
end

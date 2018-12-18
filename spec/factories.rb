FactoryBot.define do
  factory :page do
    event 
    title { "MyString" }
    body { "MyText" }
    slug { "MyString" }
  end
  factory :event do
    meta_event 
    name { "My Event 1" }
    start_date { "2018-12-11 00:00:00" }
    end_date { "2018-12-11 23:59:59" }
  end
  factory :simple_event_full, parent: :event do
    name {"Simple Event Full"}
    after(:create) do |e|
      create(:page, body: 'Gate Gate Gate', title: 'Gate', slug: 'gate', event: e)
      create(:page, body: 'Schedule Schedule Schedule', title: 'Schedule', slug: 'schedule', event: e)
      create(:page, body: 'Food Food Food', title: 'Food', slug: 'food', event: e)
      create(:page, body: 'Desc Desc Desc', title: 'Description', slug: 'description', event: e)
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

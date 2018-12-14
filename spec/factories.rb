FactoryBot.define do
  factory :event do
    meta_event 
    name { "MyString" }
    start_date { "2018-12-11 00:00:00" }
    end_date { "2018-12-11 23:59:59" }
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

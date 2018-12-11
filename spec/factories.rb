FactoryBot.define do
  factory :event do
    meta_event 
    name { "MyString" }
    start_date { "2018-12-11 14:40:46" }
    end_date { "2018-12-11 14:40:46" }
  end
  factory :meta_event do
    slug { "MyString" }
    name { "MyString" }
  end
  sequence :email do |n|
    "person#{n}@example.com"
  end
  factory :user, aliases: [:admin_user] do
    email {generate :email}
    password {Devise.friendly_token.first(8)}
  end
end

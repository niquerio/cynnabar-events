FactoryBot.define do
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

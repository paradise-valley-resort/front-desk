FactoryGirl.define do
  sequence(:email) { |n| "user-#{n}@example.com" }

  factory :user do
    first_name "John"
    last_name "Doe"
    email
    password "password123"

    trait :admin do
      admin true
    end
  end
end

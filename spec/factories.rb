FactoryGirl.define do
  sequence(:email) { |n| "user-#{n}@example.com" }

  factory :rental do
    name "Test rental"
  end

  factory :user do
    first_name "John"
    last_name "Doe"
    email
    password "password123"

    trait :active do
      deactivated_at nil
    end

    trait :admin do
      admin true
    end

    trait :deactivated do
      deactivated_at Time.zone.now
    end
  end
end

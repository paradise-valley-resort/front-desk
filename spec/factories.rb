FactoryGirl.define do
  sequence(:email) { |n| "user-#{n}@example.com" }
  sequence(:membership_id) { |n| "A#{n}"}

  factory :member do
    first_name "John"
    last_name "Doe"
    address_1 "123 Main Street"
    city "Anytown"
    state "MO"
    zip_code "12345"
    membership_id

    trait :active do
      deactivated_at nil
    end

    trait :deactivated do
      deactivated_at Time.zone.now
    end
  end

  factory :rental do
    name "Test rental"

    trait :active do
      deactivated_at nil
    end

    trait :deactivated do
      deactivated_at Time.zone.now
    end
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

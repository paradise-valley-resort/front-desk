FactoryGirl.define do
  sequence(:email) { |n| "user-#{n}@example.com" }
  sequence(:membership_id) { |n| "A#{n}"}
  sequence(:request_id) { |n| "PVR#{n}"}

  factory :booking do
    starts_at { 1.day.from_now.change(hour: 15) }
    ends_at { 3.days.from_now.change(hour: 11) }
    guest_name "John Doe"
    guest_email { generate(:email) }
    request_id
    rental

    trait :pending do
      status 0
    end

    trait :approved do
      status 1
    end

    trait :rejected do
      status 2
    end

    trait :paid do
      status 3
    end

    trait :cancelled do
      status 4
    end
  end

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

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@expert-todo.com" }
    password "password"

    confirmed_at DateTime.current

    trait :sign_up do
      password_confirmation "password"
    end
  end
end

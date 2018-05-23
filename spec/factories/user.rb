FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "test#{n}@expert-todo.com" }
    password "password"
    password_confirmation "password"

    trait :sign_up do
      email "test@test.com"
    end
  end
end

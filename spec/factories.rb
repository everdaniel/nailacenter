FactoryGirl.define do
  factory :user do
    sequence(:first_name) { |n| "First name #{n}" }
    sequence(:last_name) { |n| "Last name #{n}" }
    sequence(:username) { |n| "user_#{n}" }
    sequence(:email) { |n| "email_#{n}@scdp.com" }
    password "password"
    password_confirmation "password"

    factory :admin do
      admin true
    end
  end
end
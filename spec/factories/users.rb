# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    username 'JohnDoe'
    password 'abc12345'
    password_confirmation 'abc12345'
    sequence(:email) {|n| "example#{n}@email.com"}
  end
end

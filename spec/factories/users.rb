# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "JohnDoe#{n}" }
    password 'abc12345'
    password_confirmation 'abc12345'
    sequence(:email) {|n| "example#{n}@email.com"}
    # role 'member'
  end
end

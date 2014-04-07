# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :review do
    rating Kernel::rand(5)
    body "Would recommend to a friend, but not to a friend with good taste."

    movie
  end
end

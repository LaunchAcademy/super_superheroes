# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :movie do
    title "Batmen"
    year "2008"
    superhero "Batman"
    mpaa_rating "PG-13"
    synopsis "Not the one with Heath Ledger"
    director "Terrence Malick"
  end
end

class Movie < ActiveRecord::Base
  validates :title, presence: true, uniqueness: {scope: :year}
  validates_presence_of :superhero
  validates :year, presence: true, length: {is: 4}

  validates :mpaa_rating, inclusion: {in: ["G", "PG", "PG-13", "R", "NC-17", "", nil]}
end

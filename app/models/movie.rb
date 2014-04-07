class Movie < ActiveRecord::Base
  validates :title, presence: true, uniqueness: {scope: :year}
  validates_presence_of :superhero
  validates :year, presence: true, length: {is: 4}

  validates :mpaa_rating, inclusion: {in: ["G", "PG", "PG-13", "R", "NC-17", "", nil]}

  has_many :reviews

  def average_rating
    if reviews.count > 0
      ratings = reviews.pluck(:rating)
      (ratings.reduce(:+)/1.0/ratings.length).round(2)
    else
      0
    end
  end
end

class Movie < ActiveRecord::Base
  validates :title, presence: true, uniqueness: {scope: :year}
  validates :superhero, presence: true
  validates :year, presence: true, length: {is: 4}
  validates :user, presence: true

  validates :mpaa_rating, inclusion: {in: ["G", "PG", "PG-13", "R", "NC-17", "", nil]}

  has_many :reviews, dependent: :destroy
  belongs_to :user

  def average_rating
    if reviews.count > 0
      ratings = reviews.pluck(:rating)
      (ratings.reduce(:+)/1.0/ratings.length).round(2)
    else
      0
    end
  end
end

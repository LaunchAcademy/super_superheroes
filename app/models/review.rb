class Review < ActiveRecord::Base
  validates :rating,
    presence: true,
    numericality: true,
    inclusion: { in: (0..5) }
  validates :movie, presence: true
  validates :user, presence: true

  belongs_to :movie
  belongs_to :user

end

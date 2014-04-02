class Review < ActiveRecord::Base
  validates :rating,
    presence: true,
    numericality: true,
    inclusion: { in: (0..5) }

  belongs_to :movie

  validates :movie, presence: true
end

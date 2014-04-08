class Review < ActiveRecord::Base
  validates :rating,
    presence: true,
    numericality: true,
    inclusion: { in: (0..5) }

  belongs_to :movie
  has_many :votes

  validates :movie, presence: true

  def net_votes
    @net_votes ||= calculate_votes
  end

  def calculate_votes
    if self.votes.count == 0
      0
    else
      up_votes = self.votes.where(value: "Up").count
      down_votes = self.votes.where(value: "Down").count
      up_votes - down_votes
    end
  end

end

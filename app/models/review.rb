class Review < ActiveRecord::Base
  validates :rating,
    presence: true,
    numericality: true,
    inclusion: { in: (0..5) }
  validates :movie, presence: true
  validates :user, presence: true

  belongs_to :movie
  belongs_to :user, foreign_key: "author_id"
  belongs_to :author, class_name: :User, foreign_key: "author_id"

  has_many :votes, dependent: :destroy

  validates :movie, presence: true

  def net_votes
    @net_votes ||= calculate_votes
  end

  def up_votes_count
    votes.where(value: "Up").count
  end

  def down_votes_count
    votes.where(value: "Down").count
  end

  def calculate_votes
    if self.votes.count == 0
      0
    else
      up_votes_count - down_votes_count
    end
  end

end

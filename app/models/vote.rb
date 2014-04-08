class Vote < ActiveRecord::Base
  validates :value, presence: true, inclusion: {in: ['Up', 'Down']}
  validates :user_id, presence: true
  validates :review_id, presence: true
  belongs_to :review
  belongs_to :user
end

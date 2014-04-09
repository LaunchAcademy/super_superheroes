class Vote < ActiveRecord::Base
  validates :value, presence: true, inclusion: {in: ['Up', 'Down']}

  belongs_to :review
  belongs_to :user

  validates :user, presence: true
  validates :review, presence: true
end

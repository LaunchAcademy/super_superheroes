class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :votes, dependent: :nullify
  validates :username, presence: true, uniqueness: true
  has_many :movies, dependent: :nullify
  has_many :reviews, dependent: :nullify
end

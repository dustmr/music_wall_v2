class User < ActiveRecord::Base
  has_many :tracks
  has_many :votes
  has_many :comments

  validates :username, presence: true
  validates :email, presence: true
  validates :password, presence: true
end
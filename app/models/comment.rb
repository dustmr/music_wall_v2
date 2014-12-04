class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :track

  scope :asc_comments, -> { order(created_at: :desc) }

end
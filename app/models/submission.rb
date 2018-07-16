class Submission < ApplicationRecord
  acts_as_votable

  scope :newest_first, lambda {order("created_at DESC")}

  belongs_to :user
  has_many :comments, as: :commentable

  validates_presence_of :title
  validates_presence_of :url
end

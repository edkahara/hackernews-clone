class Comment < ApplicationRecord
  acts_as_votable

  scope :newest_first, lambda {order("created_at DESC")}

  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable

  validates_presence_of :body
end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  acts_as_voter

  validates :username, uniqueness: true

  def email_required?
    false
  end

  def email_changed?
    false
  end

  has_many :submissions, dependent: :destroy
  has_many :comments, dependent: :destroy
end

class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :delete_all
  has_many :votes, dependent: :delete_all
  validates :title, :body, presence: true
end

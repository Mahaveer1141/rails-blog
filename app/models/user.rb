class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :posts
  has_many :comments
  has_many :votes
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end

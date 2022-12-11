class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # validates :username, uniqueness: true
  validates :email, uniqueness: true

  has_many :products
  has_many :deals
  has_many :reviews
  has_many :comments
  has_many :watchlists
end

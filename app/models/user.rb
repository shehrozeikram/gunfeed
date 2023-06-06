class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # validates :username, uniqueness: true
  validates :email, uniqueness: true
  validates :username, presence: true

  has_many :products
  has_many :blogs
  has_many :deals
  has_many :reviews
  has_many :comments
  has_many :watchlists
  has_many :recently_vieweds
  has_many :likes, dependent: :destroy
  has_many :unlikes, dependent: :destroy

  # has_secure_password
  before_save { self.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }

end

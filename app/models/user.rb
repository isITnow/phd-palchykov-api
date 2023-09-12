class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :api

  enum role: { basic: 0, admin: 1 }

  has_many :posts, dependent: :destroy

  validates :username, :email, :password, presence: true
end

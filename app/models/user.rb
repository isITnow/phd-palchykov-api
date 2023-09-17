class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable,
          :jwt_authenticatable, jwt_revocation_strategy: self

  enum role: { basic: 0, admin: 1 }
  
  has_many :posts, dependent: :destroy
  
  validates :username, :email, :password, presence: true

  def jwt_payload
    super
  end
end


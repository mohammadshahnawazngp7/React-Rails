class User < ApplicationRecord
  has_many :referrals
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable,
  :jwt_authenticatable, jwt_revocation_strategy: JwtBlacklist
  
  def generate_jwt
    payload = { user_id: self.id, jti: SecureRandom.uuid }
    JsonWebToken.encode(payload)
  end
end

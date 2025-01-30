class JwtBlacklist < ApplicationRecord
    # This model will store blacklisted JWT tokens
    self.table_name = 'jwt_blacklists'
  
    belongs_to :user
    validates :jti, presence: true, uniqueness: true
  
    # Define any additional logic for revoking JWTs
    # For example, remove a token when the user logs out
  end
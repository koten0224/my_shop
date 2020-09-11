class User
  class Session < ApplicationRecord
    include ValidationHelper
    paranoid_status
    has_secure_token :token
    validate :authenticate
    belongs_to :user
    attr_accessor :email, :password
    def authenticate
      user = User.find_by(email: @email)&.authenticate(@password)
      unless user
        errors[:authenticate] << 'invalid'
      else
        self.user = user
      end
    end
  end
end
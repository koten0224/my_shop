class User
  class Session
    include ActiveModel::Model
    include User::Validation
    validate :authenticate
    attr_accessor :email, :password
    attr_reader :user
    def authenticate
      user = User.find_by(email: @email)&.authenticate(@password)
      unless user
        errors[:authenticate] << 'invalid'
      else
        @user = user
      end
    end
  end
end
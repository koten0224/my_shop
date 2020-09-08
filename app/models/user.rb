class User < ApplicationRecord
  has_secure_password
  before_validation :auto_fill_password, if: ->{Rails.env.development?}
  validates :name, :email, :password, presence: true
  validates :name, length: {in: 2..50}
  validates :name, format: {with: ValidFormats::USER_NAME_REGEX}
  validates :password, length: {in: 6..20}
  validates :email, length: {in: 8..100}
  sub_regex = '[0-9a-z]+([_-][0-9a-z]+)*'
  sub_regex_2nd = "#{sub_regex}(\\.#{sub_regex})"
  email_regex = /\A#{sub_regex_2nd}*@#{sub_regex_2nd}+\z/
  validates :email, format: {with: email_regex}
  def auto_fill_password
    if password_digest.nil?
      self.password = '111111'
      self.password_confirmation = '111111'
    end
  end
end

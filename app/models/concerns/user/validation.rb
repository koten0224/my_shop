class User
  module Validation
    def self.included(base)
      base.class_eval do
        validates :email, :password, presence: true
        validates :password, length: {in: 6..20}
        validates :email, length: {in: 8..100}
        sub_regex = '[0-9a-z]+([_-][0-9a-z]+)*'
        sub_regex_2nd = "#{sub_regex}(\\.#{sub_regex})"
        email_regex = /\A#{sub_regex_2nd}*@#{sub_regex_2nd}+\z/
        validates :email, format: {with: email_regex}
      end
    end
  end
end
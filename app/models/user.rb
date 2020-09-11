class User < ApplicationRecord
  include ValidationHelper
  paranoid_status
  has_secure_password
  before_validation :auto_fill_password, if: ->{Rails.env.development?}
  scope :token, ->(token){joins(:sessions).find_by(user_sessions: {token: token})}
  after_create :create_shop
  validates :name, presence: true
  validates :name, length: {in: 2..50}
  validates :name, format: {with: ValidFormats::USER_NAME_REGEX}
  validates :email, uniqueness: true
  has_many :sessions
  has_many :shop_roles, class_name: 'Shop::Role', dependent: :destroy
  has_many :own_shop_roles, ->{admin}, class_name: 'Shop::Role'
  has_many :own_shops, through: :own_shop_roles, source: :shop
  has_many :serve_shop_roles, ->{staff}, class_name: 'Shop::Role'
  has_many :serve_shops, through: :serve_shop_roles, source: :shop
  has_many :shopping_shop_roles, ->{customer}, class_name: 'Shop::Role'
  has_many :shopping_shops, through: :shopping_shop_roles, source: :shop

  def auto_fill_password
    if password_digest.nil?
      self.password = '111111'
      self.password_confirmation = '111111'
    end
  end

  def create_shop( attributes={name: self.name} )
    Shop.create(attributes.merge(admin: self))
  end
end

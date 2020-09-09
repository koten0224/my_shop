class User < ApplicationRecord
  include User::Validation
  has_secure_password
  before_validation :auto_fill_password, if: ->{Rails.env.development?}
  validates :name, presence: true
  validates :name, length: {in: 2..50}
  validates :name, format: {with: ValidFormats::USER_NAME_REGEX}
  validates :email, uniqueness: true

  has_many :shop_roles, class_name: 'Shop::Role'
  has_many :shops, through: :shop_roles

  def auto_fill_password
    if password_digest.nil?
      self.password = '111111'
      self.password_confirmation = '111111'
    end
  end

  def own_shops
    Shop.joins(:shop_roles).where(shop_roles: {role: 'admin'})
  end

  def serve_shops
    Shop.joins(:shop_roles).where(shop_roles: {role: 'staff'})
  end

  def shopping_shops
    Shop.joins(:shop_roles).where(shop_roles: {role: 'customer'})
  end
end

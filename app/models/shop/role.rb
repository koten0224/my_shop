class Shop
  class Role < ApplicationRecord
    paranoid_status
    VALID_ROLES = %w(admin staff customer).freeze
    scope :admin, ->{where(role: 'admin')}
    scope :staff, ->{where(role: 'staff')}
    scope :customer, ->{where(role: 'customer')}
    belongs_to :user
    belongs_to :shop
    validates :user_id, :shop_id, :role, presence: true
    validates :user_id, uniqueness: {scope: [:shop, :status]}
    validates :role, uniqueness: {scope: [:shop, :status]}, if: ->{role=='admin'}
    validates :role, inclusion: {in: VALID_ROLES}
  end
end

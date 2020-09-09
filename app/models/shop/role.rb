class Shop
  class Role < ApplicationRecord
    VALID_ROLES = %w(admin staff customer).freeze
    attribute :status, default: 'active'
    default_scope ->{where.not(status: 'removed')}
    belongs_to :user
    belongs_to :shop
    validates :user_id, :shop_id, :role, presence: true
    validates :user_id, uniqueness: {scope: :shop}
    validates :role, uniqueness: {scope: :shop}, if: ->{role=='admin'}
    validates :role, inclusion: {in: VALID_ROLES}
  end
end

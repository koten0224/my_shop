class Shop < ApplicationRecord
  paranoid_status
  validates :name, presence: true
  validates :admin, presence: true, on: :create
  has_many :roles, dependent: :destroy
  has_many :users, through: :roles
  has_one :admin_role, ->{admin}, class_name: 'Shop::Role'
  has_one :admin, through: :admin_role, source: :user
  has_many :staff_roles, ->{staff}, class_name: 'Shop::Role'
  has_many :staffs, through: :staff_roles, source: :user
  has_many :customer_roles, ->{customer}, class_name: 'Shop::Role'
  has_many :customers, through: :customer_roles, source: :user
  after_recover :recover_associations

  def recover_associations
    shop_roles.unscoped.admin.last.recover
    shop_roles.unscoped.staff.each(&:recover)
    shop_roles.unscoped.customer.each(&:recover)
  end
end

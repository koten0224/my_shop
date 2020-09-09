class Shop < ApplicationRecord
  attr_writer :admin
  attribute :status, default: 'active'
  validates :name, presence: true
  validates :admin, presence: true, on: :create
  after_create :create_admin
  has_many :shop_roles, class_name: 'Shop::Role'
  default_scope ->{where.not(status: 'removed')}

  def admin
    @admin ||= User.joins(:shop_roles).find_by(shop_roles: {shop_id: id, role: 'admin'})
  end

  def staffs
    @staffs ||= User.joins(:shop_roles).where(shop_roles: {shop_id: id, role: 'staff'})
  end

  def customers
    @customers ||= User.joins(:shop_roles).where(shop_roles: {shop_id: id, role: 'customer'})
  end
  
  def hr
    HumanResourceService.new(self)
  end

  def reload
    @admin = @staffs = @customers = nil
    super
  end

  private

  def create_admin
    shop_role = Shop::Role.unscoped.find_or_initialize_by(user_id: @admin.id, shop_id: id)
    shop_role.role = 'admin'
    shop_role.status = 'active'
    shop_role.save
  end
end

class Shop
  class HumanResourceService
    def initialize(shop)
      @shop = shop
    end

    def add_staff(user)
      shop_role = Shop::Role.unscoped.find_or_initialize_by(user_id: user.id, shop_id: @shop.id)
      shop_role.role = 'staff'
      shop_role.status = 'active'
      shop_role.save
    end
    
    def add_customer(user)
      shop_role = Shop::Role.unscoped.find_or_initialize_by(user_id: user.id, shop_id: @shop.id)
      shop_role.role = 'customer'
      shop_role.status = 'active'
      shop_role.save
    end
    
    def change_admin(user)
      Shop::Role.unscoped.find_by(user_id: @shop.admin.id).update(role: 'staff')
      shop_role = Shop::Role.unscoped.find_or_initialize_by(user_id: user.id, shop_id: @shop.id)
      shop_role.role = 'admin'
      shop_role.status = 'active'
      @shop.admin = user
      shop_role.save
    end
  
    def kick_member(user)
      Shop::Role.find_by(user_id: user.id, shop_id: @shop.id)&.update(status: 'removed')
    end
  end
end
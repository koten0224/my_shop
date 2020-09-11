class Shop
  class RoleService
    include ActiveModel::Model
    attr_accessor :shop, :user, :role
    validates :shop, :user, presence: true
    validates :role, inclusion: {in: Role::VALID_ROLES}

    def perform
      return if invalid?
      if @role == 'admin'
        Role.find_by(shop_id: @shop.id, user_id: @shop.admin&.id)&.update(role: 'staff')
      end
      Role.find_or_create_by(params).update(role: @role)
      @shop.reload
    end

    def params
      {shop_id: @shop.id, user_id: @user.id}
    end
  end
end
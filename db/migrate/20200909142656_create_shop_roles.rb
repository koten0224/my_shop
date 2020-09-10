class CreateShopRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :shop_roles do |t|
      t.references :user, null: false, foreign_key: true
      t.references :shop, null: false, foreign_key: true
      t.string :role
      t.string :status, default: 'active'
      
      t.index :role
      t.index :status
      t.timestamps
    end
    add_index :users, :email
    add_column :users, :status, :string, default: 'active'
    add_index :users, :status
    change_column_default :shops, :status, from: nil, to: 'active'
  end
end
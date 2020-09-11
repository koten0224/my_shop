class AddTableSession < ActiveRecord::Migration[6.0]
  def change
    create_table :user_sessions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :token, null:false
      t.string :status, default: 'active'
      
      t.index :token
      t.index :status
      t.timestamps
    end
  end
end

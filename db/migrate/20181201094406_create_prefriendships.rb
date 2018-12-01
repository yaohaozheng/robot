class CreatePrefriendships < ActiveRecord::Migration
  def change
    create_table :prefriendships do |t|
      t.integer :user_id, index: true
      t.integer :prefriend_id, index: true


      t.timestamps null: false
    end
  end
end

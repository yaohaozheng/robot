class CreateEvaluates < ActiveRecord::Migration
  def change
    create_table :evaluates do |t|
      t.integer :user_id
      t.integer :score

      t.timestamps null: false
    end
  end
end

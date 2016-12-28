class CreateReactions < ActiveRecord::Migration
  def change
    create_table :reactions do |t|
      t.integer :emotion, default: 0, null: false, limit: 1
      t.integer :timeline_id
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :reactions, [:timeline_id, :user_id], unique: true
    add_index :reactions, :emotion
  end
end

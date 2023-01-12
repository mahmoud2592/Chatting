class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.integer :user_id, null: false
      t.string :likeable_type, null: false
      t.integer :likeable_id, null: false
      t.timestamps
      t.index [:likeable_type, :likeable_id], name: "index_likes_on_likeable"
      t.index [:user_id, :likeable_type, :likeable_id], name: "index_likes_on_user_id_and_likeable_type_and_likeable_id", unique: true
      t.index [:user_id], name: "index_likes_on_user_id"
    end
  end
end

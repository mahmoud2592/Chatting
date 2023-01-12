class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.text :body
      t.references :user, null: false, foreign_key: true
      t.integer :likes_count, default: 0, null: false
      t.timestamps
    end
  end
end

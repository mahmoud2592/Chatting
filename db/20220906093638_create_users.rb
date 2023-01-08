class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :mobile, null: false
      t.string :name
      t.string :type, null: false
      t.string :password_digest, null: false

      t.timestamps
    end
  end
end

class CreateUsers < ActiveRecord::Migration[7.0]
  def up
    create_table :users do |t|
      t.string :mobile, null: false
      t.string :name
      t.string :type, null: false
      t.string :password_digest, null: false
      t.datetime :confirmed_at
      t.string :confirmation_token
      t.string :reset_password_otp
      t.timestamps
    end
  end

  def def down
    drop_table :users
  end
end

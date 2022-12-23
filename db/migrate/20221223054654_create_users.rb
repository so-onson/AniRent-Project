class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :first_name, default: "", null: false
      t.string :email, default: "", null: false
      t.integer :role, default: 0
      t.string :password_digest

      t.timestamps

      t.index ["email"], name: "index_users_on_email", unique: true
    end
  end
end

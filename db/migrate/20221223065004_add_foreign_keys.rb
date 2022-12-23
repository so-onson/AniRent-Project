class AddForeignKeys < ActiveRecord::Migration[7.0]
  def change

    add_foreign_key :customers, :users


    add_foreign_key :managers, :users

    add_column :orders, :customer_id, :integer
    add_foreign_key :orders, :customers

    add_column :orders, :animal_id, :integer
    add_foreign_key :orders, :animals
  end
end

class CreateAnimals < ActiveRecord::Migration[7.0]
  def change
    create_table :animals do |t|
      t.string :name
      t.string :breed
      t.text :description
      t.boolean :in_order, default: false

      t.timestamps
    end
  end
end

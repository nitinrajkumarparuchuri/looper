class CreateLocations < ActiveRecord::Migration[8.0]
  def change
    create_table :locations do |t|
      t.string :name
      t.text :description
      t.integer :x
      t.integer :y
      t.references :game, null: false, foreign_key: true

      t.timestamps
    end
  end
end

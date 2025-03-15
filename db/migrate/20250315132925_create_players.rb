class CreatePlayers < ActiveRecord::Migration[8.0]
  def change
    create_table :players do |t|
      t.string :name
      t.string :role
      t.references :game, null: false, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end

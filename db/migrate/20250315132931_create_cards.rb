class CreateCards < ActiveRecord::Migration[8.0]
  def change
    create_table :cards do |t|
      t.string :content
      t.string :card_type
      t.references :game, null: false, foreign_key: true
      t.references :player, null: true, foreign_key: true

      t.timestamps
    end
  end
end

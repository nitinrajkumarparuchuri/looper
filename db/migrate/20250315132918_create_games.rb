class CreateGames < ActiveRecord::Migration[8.0]
  def change
    create_table :games do |t|
      t.string :status
      t.integer :current_turn

      t.timestamps
    end
  end
end

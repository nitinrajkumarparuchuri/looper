class AddGameWonToGames < ActiveRecord::Migration[8.0]
  def change
    add_column :games, :game_won, :boolean
  end
end

class AddCurrentTurnPlayerToGames < ActiveRecord::Migration[8.0]
  def change
    add_column :games, :current_turn_player_id, :integer
  end
end

class AddPrimaryRainmakerLocationToGames < ActiveRecord::Migration[8.0]
  def change
    add_column :games, :primary_rainmaker_location_id, :integer
  end
end

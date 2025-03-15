class AddHasRainmakerToLocations < ActiveRecord::Migration[8.0]
  def change
    add_column :locations, :has_rainmaker, :boolean
  end
end

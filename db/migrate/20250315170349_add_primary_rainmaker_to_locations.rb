class AddPrimaryRainmakerToLocations < ActiveRecord::Migration[8.0]
  def change
    add_column :locations, :primary_rainmaker, :boolean
  end
end

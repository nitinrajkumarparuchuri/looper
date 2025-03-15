class CreateRainmakerKills < ActiveRecord::Migration[8.0]
  def change
    create_table :rainmaker_kills do |t|
      t.references :player, null: false, foreign_key: true
      t.references :location, null: false, foreign_key: true

      t.timestamps
    end
  end
end

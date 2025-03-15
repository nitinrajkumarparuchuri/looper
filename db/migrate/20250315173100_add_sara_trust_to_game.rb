class AddSaraTrustToGame < ActiveRecord::Migration[8.0]
  def change
    add_column :games, :sara_trusts_young_joe, :boolean
  end
end

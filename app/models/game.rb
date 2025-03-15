class Game < ApplicationRecord
  has_many :players
  has_many :cards
  has_many :locations
  belongs_to :current_turn_player, class_name: 'Player', optional: true
  belongs_to :primary_rainmaker_location, class_name: "Location", optional: true
end

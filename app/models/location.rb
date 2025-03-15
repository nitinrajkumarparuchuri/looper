class Location < ApplicationRecord
  belongs_to :game
  has_many :player_positions
end

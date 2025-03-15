class Player < ApplicationRecord
  belongs_to :game
  has_many :cards
  has_one :player_position
  has_many :rainmaker_kills

  enum :status, { alive: 'alive', dead: 'dead' }, prefix: true

  def current_turn?
    game.current_turn_player_id == id
  end

  def has_card?(card_type)
    cards.exists?(card_type: card_type)
  end  

  def has_all_clue_cards?
    required = ["Clue", "Chrono Key", "Tracker"]
    required.all? { |name| cards.exists?(name: name) }
  end
  
end

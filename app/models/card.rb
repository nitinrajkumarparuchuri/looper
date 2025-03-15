class Card < ApplicationRecord
  belongs_to :game
  belongs_to :player, optional: true # Some cards are shared

  enum :card_type, { action: 'action', event: 'event', objective: 'objective' }, prefix: true
end

# Clear existing data
PlayerPosition.destroy_all
Card.destroy_all
Player.destroy_all
Location.destroy_all
Game.destroy_all

# Create a new game
game = Game.create!(status: "active", current_turn: 0)

# Define locations
locations_data = [
  ["Farmhouse", "Sara's home", 0, 0],
  ["City", "Urban area", 5, 5],
  ["Hideout", "Secret location", 3, 1],
  ["Abandoned School", "Empty ruins", 1, 4],
  ["Train Station", "Busy crossing point", 4, 2],
  ["Candidate House 1", "Unknown child", 6, 0],
  ["Candidate House 2", "Unknown child", 6, 1],
  ["Candidate House 3", "Unknown child", 6, 2]
]

# Create locations
locations = locations_data.map do |name, description, x, y|
  Location.create!(name: name, description: description, x: x, y: y, game: game)
end

# Create players and assign them to random locations
roles = %w[young_joe old_joe gat_man sara]
players = roles.map do |role|
  player = Player.create!(name: role.titleize, role: role, game: game, status: :alive)
  PlayerPosition.create!(player: player, location: locations.sample)
  player
end

# Set the first player as the current turn player
game.update!(current_turn_player: players.first)

# Add sample cards
Card.create!(content: "Move 3 spaces", card_type: :action, game: game)
Card.create!(content: "Time loop glitch: Swap location with another", card_type: :event, game: game)
Card.create!(
  content: "Rainmaker is crying. Calm him down.",
  card_type: :objective,
  player: players.find { |p| p.role == "sara" },
  game: game
)
game = Game.last # or however you're getting the current game
rainmaker_locations = Location.where(has_rainmaker: true)
game.update(primary_rainmaker_location_id: rainmaker_locations.sample.id)

puts "✅ Seeded 1 game with #{players.count} players, #{locations.count} locations, and 3 cards."
puts "🎯 Current turn player: #{game.current_turn_player.name}"

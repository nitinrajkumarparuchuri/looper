class PlayersController < ApplicationController
  def show
    @player = Player.find(params[:id])
  end

  def move
    @player = Player.find(params[:id])
    
    if @player != @player.game.current_turn_player
      redirect_to player_path(@player), alert: "It's not your turn!"
      return
    end
  
    location = Location.find(params[:location_id])
    
    @player.player_position.update(location: location)

    # Rainmaker kill logic
    if @player.role == "gat_man"
      target = Player.find_by(name: ["Old Joe", "Young Joe", "Sara"], game: @player.game)
      next_location = @player.player_position.location
    
      if target && target.player_position&.location == next_location
        case target.name
        when "Old Joe", "Young Joe"
          @player.game.update(game_won: true)
          flash[:notice] = "🎯 Gat Man captured #{target.name} and won the game!"
        when "Sara"
          # Reset all rainmaker locations
          Location.update_all(has_rainmaker: false)
          # Assign new random locations
          Location.order("RANDOM()").limit(3).update_all(has_rainmaker: true)
          flash[:alert] = "⚠️ Gat Man captured Sara! Rainmaker was triggered and locations have been scrambled!"
        end
      end
    end
    
    
    if @player.role == "old_joe"  && location.has_rainmaker?
      unless RainmakerKill.exists?(player: @player, location: location)
        RainmakerKill.create(player: @player, location: location)
        rainmakers_total = Location.where(has_rainmaker: true).count
        kills = @player.rainmaker_kills.count

        if kills == rainmakers_total
          @player.game.update(game_won: true)
          flash[:notice] = "You eliminated the final Rainmaker and won the game!"
        else
          flash[:notice] = "You eliminated a Rainmaker at #{location.name}!"
        end
      end
    end
  
    redirect_to player_path(@player)
  end

  def relocate_rainmaker
    @player = Player.find(params[:id]) # ✅ You were missing this line

    if @player.name != "Sara"
      redirect_to player_path(@player), alert: "Only Sara can do that."
      return
    end
  
    old_location = Location.find_by(primary_rainmaker: true)
    new_location = Location.find(params[:new_location_id])
  
    if old_location && new_location
      old_location.update(primary_rainmaker: false)
      new_location.update(primary_rainmaker: true)
      redirect_to player_path(@player), notice: "Primary Rainmaker moved to #{new_location.name}."
    else
      redirect_to player_path(@player), alert: "Invalid location."
    end
  end
  
  def self_terminate
    if @player.name == "Young Joe" &&
       @player.has_all_clue_cards? &&
       @player.game.sara_trusts_young_joe
  
      @player.game.update(game_won: true, winner: "Young Joe")
      redirect_to player_path(@player), notice: "You ended your loop and won the game!"
    else
      redirect_to player_path(@player), alert: "You cannot end your loop yet."
    end
  end
  
  def draw_card
    player = Player.find(params[:id])
    card = player.game.cards.where(player_id: nil).sample
  
    if card
      card.update(player: player)
      redirect_to player_path(player), notice: "You drew a card: #{card.content}"
    else
      redirect_to player_path(player), alert: "No cards left to draw."
    end
  end
  
  def play_card
    player = Player.find(params[:id])
    card = player.cards.find_by(id: params[:card_id])
  
    if card
      card.update(player: nil) # You could also destroy or mark as used
      redirect_to player_path(player), notice: "You played: #{card.content}"
    else
      redirect_to player_path(player), alert: "You don't have that card."
    end
  end  
end

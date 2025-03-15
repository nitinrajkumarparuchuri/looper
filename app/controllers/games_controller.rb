class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])
    @players = @game.players.includes(:player_position, :cards)
    @locations = @game.locations
    @cards = @game.cards
  end

  def board
    @game = Game.find(params[:id])
    @locations = Location.all
    @players = @game.players.includes(:player_position => :location)
  end
  

  def advance_turn
    game = Game.find(params[:id])
    players = game.players.order(:id)
    current_index = players.index(game.current_turn_player)
    next_player = players[(current_index + 1) % players.size]
  
    game.update(current_turn: game.current_turn + 1, current_turn_player: next_player)
    redirect_to player_path(next_player), notice: "It's now #{next_player.name}'s turn!"

    # redirect_to game_path(game), notice: "Turn advanced to #{next_player.name}"
  end  
end

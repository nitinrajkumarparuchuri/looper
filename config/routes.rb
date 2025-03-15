Rails.application.routes.draw do
  resources :games, only: [:index, :show] do
    post :advance_turn, on: :member
  end
  get "/games/:id/board", to: "games#board", as: :game_board


  # Route to view rules
  get '/rules', to: 'pages#rules'
  post "/players/:id/relocate_rainmaker", to: "players#relocate_rainmaker", as: :relocate_rainmaker_player
  post "/players/:id/self_terminate", to: "players#self_terminate", as: :self_terminate_player

  # Player routes (standalone, includes move action)
  resources :players, only: [:show] do
    member do
      post :move
      post :draw_card
      post :play_card
    end
  end
end

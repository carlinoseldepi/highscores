module Api
    
    module V1
      
      class GamesController < Api::V1::ApiController
  
        before_action :set_game, only: [:show, :update, :destroy]
        
        #
        # call: http://localhost:3000/api/v1/games
        #
        # GET /games
        def index
          @games = Game.all
          json_response(@games)
        end
  
        # GET /games/:id
        def show
          json_response(@game)
        end
  
        # POST /games
        def create
          @game = Game.create!(game_params)
          json_response(@game, :created)
        end
  
        # PUT /games/:id
        def update
          @game.update(game_params)
          head :no_content
        end
  
        # DELETE /games/:id
        def destroy
          @game.destroy
          head :no_content
        end
  
        private
  
        def game_params
          params.require(:game).permit(:name)
        end
  
        def set_game
          @game = Game.find(params[:id])
        end
        
      end
    end   
  end
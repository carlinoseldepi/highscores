class Game < ApplicationRecord
  
  ## const
  TOP_GENERAL = 10
  TOP_GAME = 5

  ## relations
  has_many :scores, dependent: :destroy
  
  ## validations
  validates :name, presence: true
  
  
  ## class methods
  class << self
    

    #
    # Return a hash with the top 5 players (ordered by score => max to min) for every game. 
    #
    def top_players_by_game
      result = {}

      Game.all.each do |game|
        result[game.name] = Score.select("player_email, SUM(score) as total_score").group("player_email").order("SUM(score) desc").where("game_id=?", game.id).limit(Game::TOP_GAME)
      end

      result
    end

    #
    # Return the top 10 players with more points accord to the rules points-positions.
    # Receive a hash with games and its players ordered for scores in the game
    #
    def top_players_general(hash={})
      return if hash.blank?

      result = {}

      # points to assign to positions
      points = [25, 18, 15, 12, 10, 0]

      hash.each_pair do |game, players|

        players.each_with_index do |player, index|
          next if index>5 #only 5 first players have points

          result[player.player_email] ||= 0

          # acumulate points to the player in each game
          result[player.player_email] += points[index]
        end
      end

      result = result.sort_by{|email, score| score}.reverse[0..Game::TOP_GENERAL]

      result
    end
    
  end
  
end

class Game < ApplicationRecord
  
  ## relations
  has_many :scores, dependent: :destroy
  
  ## validations
  validates :name, presence: true
  
  
  ## class methods
  class << self
    
    def top_players_by_game
      result = {}

      Game.all.each do |game|
        result[game.name] = Score.select("player_email, SUM(score) as total_score").group("player_email").order("SUM(score) desc").where("game_id=?", game.id)
      end

      result
    end


    def top_players_general(hash={})
      return if hash.blank?

      result = {}

      points = [25, 18, 15, 12, 10, 0]

      hash.each_pair do |game, players|

        players.each_with_index do |player, index|
          next if index>5
          result[player.player_email] ||= 0

          result[player.player_email] += points[index]
        end
      end

      result = result.sort_by{|email, score| score}.reverse

      result
    end
    
  end
  
end

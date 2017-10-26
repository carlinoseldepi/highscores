class Score < ApplicationRecord
  
  ## relations
  belongs_to :game
  
  ## validations
  validates :player_email, presence: true
  validates :score, presence: true
  validates :game_id, presence: true
  
end

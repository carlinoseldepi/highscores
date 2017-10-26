class Game < ApplicationRecord
  
  ## relations
  has_many :scores, dependent: :destroy
  
  ## validations
  validates :name, presence: true
  
  
  ## class methods
  class << self
    
    def games_to_select
      Game.all.select{|x| [x.id, x.name]}
    end
    
  end
  
end

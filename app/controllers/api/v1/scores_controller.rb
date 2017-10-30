module Api
  
  module V1
    
    class ScoresController < Api::V1::ApiController
      
      #
      # call: http://localhost:3000/api/v1/scores.json
      #
      def index
        @scores = Score.all
        
        #render json: @scores
      end
      
    end
  end   
end
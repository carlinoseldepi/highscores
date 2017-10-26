module Api
  
  module V1
    
    class ContextsController < Api::V1::ApiController
      
      #
      # call: http://localhost:3000/api/v1/scores.json
      #
      def index
        @scores = Score.all
        respond_with @scores
      end
      
    end
  end   
end
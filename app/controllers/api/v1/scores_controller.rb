module Api
  
  module V1
    
    class ScoresController < Api::V1::ApiController

      # protect all actions from exceptions
      rescue_from StandardError do |exception|
        render json: { error: exception.message }, status: 500
      end

      before_action :set_score, only: [:show, :update, :destroy]
      
      #
      # call: http://localhost:3000/api/v1/scores
      #
      # GET /scores
      def index
        @scores = Score.all
        json_response(@scores)
      end

      # GET /scores/:id
      def show
        json_response(@score)
      end

      # POST /scores
      def create
        @score = Score.create!(score_params)
        json_response(@score, :created)
      end

      # PUT /scores/:id
      def update
        @score.update(score_params)
        head :no_content
      end

      # DELETE /scores/:id
      def destroy
        @score.destroy
        head :no_content
      end

      private

      def score_params
        params.require(:score).permit(:player_email, :score, :game_id)
      end

      def set_score
        @score = Score.find(params[:id]) #rescue nil
      end
      
    end
  end   
end
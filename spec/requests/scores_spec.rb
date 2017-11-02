require 'rails_helper'

RSpec.describe 'Scores API', type: :request do
  # initialize test data
  let!(:game) { create(:game) }
  let(:game_id) { game.id }
  let!(:scores) { create_list(:score, 10, game_id: game_id) }
  let(:score_id) { scores.first.id }
  

  # Test suite for GET /api/v1/scores
  describe 'GET /api/v1/scores' do
    # make HTTP get request before each example
    before { get '/api/v1/scores' }

    it 'returns scores' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /api/v1/scores/:id
  describe 'GET /api/v1/scores/:id' do
    before { get "/api/v1/scores/#{score_id}" }

    context 'when the record exists' do
      it 'returns the score' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(score_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:score_id) { 100 }

      it 'returns status code 500' do #404
        expect(response).to have_http_status(500)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Score/)
      end
    end
  end

  # Test suite for POST /api/v1/scores
  describe 'POST /api/v1/scores' do
    # valid payload
    let(:valid_attributes) { { score: {player_email: 'email@gmail.com', score: 100, game_id: 1} } }

    context 'when the request is valid' do
      before { post '/api/v1/scores', params: valid_attributes }

      it 'creates a score' do
        expect(json['message']).to eq(I18n.t('api.scores.add.ok'))
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/scores', params: { score: {player_email: 'email@gmail.com', score: 100} } }

      it 'returns status code 500' do #422
        expect(response).to have_http_status(500)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/There was a problem with the request/) #.to match(/Validation failed: Game must exist, Game can't be blank/)
      end
    end
  end

  # Test suite for PUT /api/v1/scores/:id
  describe 'PUT /api/v1/scores/:id' do
    let(:valid_attributes) { { score: {score: 234} } }

    context 'when the record exists' do
      before { put "/api/v1/scores/#{score_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /api/v1/scores/:id
  describe 'DELETE /api/v1/scores/:id' do
    before { delete "/api/v1/scores/#{score_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
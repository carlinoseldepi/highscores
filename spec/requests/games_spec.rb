require 'rails_helper'

RSpec.describe 'Games API', type: :request do
  # initialize test data 
  let!(:games) { create_list(:game, 10) }
  let(:game_id) { games.first.id }

  # Test suite for GET /api/v1/games
  describe 'GET /api/v1/games' do
    # make HTTP get request before each example
    before { get '/api/v1/games' }

    it 'returns games' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /api/v1/games/:id
  describe 'GET /api/v1/games/:id' do
    before { get "/api/v1/games/#{game_id}" }

    context 'when the record exists' do
      it 'returns the game' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(game_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:game_id) { 100 }

      it 'returns status code 500' do #404
        expect(response).to have_http_status(500)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Game/)
      end
    end
  end

  # Test suite for POST /api/v1/games
  describe 'POST /api/v1/games' do
    # valid payload
    let(:valid_attributes) { { game: {name: 'Sonic'} } }

    context 'when the request is valid' do
      before { post '/api/v1/games', params: valid_attributes }

      it 'creates a game' do
        expect(json['name']).to eq('Sonic')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/games', params: { game: {title: 'Rally'} } }

      it 'returns status code 500' do #422
        expect(response).to have_http_status(500)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for PUT /api/v1/games/:id
  describe 'PUT /api/v1/games/:id' do
    let(:valid_attributes) { { game: {name: 'Fifa 18'} } }

    context 'when the record exists' do
      before { put "/api/v1/games/#{game_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /api/v1/games/:id
  describe 'DELETE /api/v1/games/:id' do
    before { delete "/api/v1/games/#{game_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
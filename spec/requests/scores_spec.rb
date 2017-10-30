# app/requests/scores_spec.rb
require 'rails_helper'

RSpec.describe 'Scores API' do
  # Initialize the test data
  let!(:game) { create(:game) }
  let!(:scores) { create_list(:score, 20, game_id: game.id) }
  let(:game_id) { game.id }
  let(:id) { scores.first.id }

  # Test suite for GET /games/:game_id/scores
  describe 'GET /games/:game_id/scores' do
    before { get "/games/#{game_id}/scores" }

    context 'when game exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all game scores' do
        expect(json.size).to eq(20)
      end
    end

    context 'when game does not exist' do
      let(:game_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find game/)
      end
    end
  end

  # Test suite for GET /games/:game_id/scores/:id
  describe 'GET /games/:game_id/scores/:id' do
    before { get "/games/#{game_id}/scores/#{id}" }

    context 'when game score exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the score' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when game score does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find score/)
      end
    end
  end

  # Test suite for PUT /games/:game_id/scores
  describe 'POST /games/:game_id/scores' do
    let(:valid_attributes) { { player_email: 'email@email.com', score: 150 } }

    context 'when request attributes are valid' do
      before { post "/games/#{game_id}/scores", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/games/#{game_id}/scores", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: player_email can't be blank/)
      end
    end
  end

  # Test suite for PUT /games/:game_id/scores/:id
  describe 'PUT /games/:game_id/scores/:id' do
    let(:valid_attributes) { { player_email: 'player@mail.com' } }

    before { put "/games/#{game_id}/scores/#{id}", params: valid_attributes }

    context 'when score exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the score' do
        updated_score = score.find(id)
        expect(updated_score.player_email).to match(/player@email.com/)
      end
    end

    context 'when the score does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find score/)
      end
    end
  end

  # Test suite for DELETE /games/:id
  describe 'DELETE /games/:id' do
    before { delete "/games/#{game_id}/scores/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
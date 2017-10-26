Rails.application.routes.draw do
  resources :scores
  resources :games do 
    collection do
      get 'top_players'
    end
  end
  
  
  namespace "api", defaults: { format: :json } do
    namespace "v1" do 
      resources :scores, only: [:index]
    end
  end
  
  root :to => 'games#top_players'
end

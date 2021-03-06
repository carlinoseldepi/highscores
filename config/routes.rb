Rails.application.routes.draw do
  resources :scores
  resources :games do
    collection do
      get 'top_players'
    end

    resources :scores 
  end
  
  
  namespace "api", defaults: { format: :json } do
    namespace "v1" do 
      resources :games
      resources :scores
    end
  end
  
  root :to => 'scores#new'
end
